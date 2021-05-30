/*
	File:		AppearanceSampleMain.c

	Contains:	Main application code for our sample app.

	Version:    CarbonLib 1.0.2 SDK

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

	© 1997-2000 by Apple Computer, Inc. All rights reserved.
*/

//
//	This program is actually based on the skeleton code from Scott Knaster's
//	Macintosh Programming Secrets book. So, if you're looking at this code,
//	Scott, it may look slightly familiar.
//

#ifdef __MRC__
#include <Events.h>
#include <MacTypes.h>
#include <Files.h>
#include <Gestalt.h>
#include <Processes.h>
#include <Movies.h>
#include <Menus.h>
#include <Fonts.h>
#include <DiskInit.h>
#include <Devices.h>
#include <TextUtils.h>
#include <Resources.h>
#include <Appearance.h>
#include <Script.h>
#endif	// __MRC__

#include "FinderWindow.h"
#include "DialogWindow.h"
#include "BevelDialog.h"
#include "BevelImageAPIWindow.h"
#include "CDEFTester.h"
#include "LiveFeedbackDialog.h"
#include "MegaDialog.h"
#include "UtilityWindow.h"
#include "SideUtilityWindow.h"
#include "MenuDrawing.h"
#include "ProxyDialog.h"
#include "Offscreen.h"

/* ==================================================================================*/
/* ======================= R E S O U R C E   N U M B E R S ==========================*/
/* ==================================================================================*/

enum
{
	kAlertStartupError		= 129
};

enum
{
	kErrorStrings			= 128,
	kWeirdSystemString		= 1,
	kNoAppearanceString		= 2,
	kResourceMissingString	= 3
};

enum
{
	kAboutBoxDialogID		= 5000
};

#define kObjectWindowKind		2000

/* 	The following constants are used to identify menus and their items. The menu IDs
	have an "m" prefix and the item numbers within each menu have an "i" prefix. */

enum
{
	rMenuBar				= 128				/* application's menu bar */
};

enum
{
	mApple					= 128,				/* Apple menu */
	iAbout					= 1
};

enum
{
	mFile					= 129,				/* File menu */
	iClose					= 1,
	iQuitSeperator			= 2,
	iQuit					= 3
};

enum
{
	mExamples				= 130,
	iFinderWindow			= 1,
	iDialogWindow			= 2,
	iBevelDialog			= 3,
	iNewThemeDialog			= 4,
	iStandardAlert			= 5,
	iBevelButtonContent		= 6,
	iCDEFTester				= 7,
	iLiveFeedbackDialog		= 8,
	iMegaDialog				= 9,
	iUtilityWindow			= 10,
	iSideUtilityWindow		= 11,
	iAutoSizeDialog			= 12,
	iVerticalZoom			= 13,
	iHorizontalZoom			= 14,
	iProxyPathDialog		= 15
};

enum
{
	mTestAPI				= 148,
	iMenuDrawing			= 1,
	iDumpControlHierarchy	= 2,
	iHideMenu				= 3,
	iDialogTimeouts			= 4
};

enum
{
	kHorizZoomKind			= 128,
	kVertZoomKind			= 129
};

enum
{
	kMenuModifiers				= 145,
	kNoModifiersItem			= 1,
	kShiftModifierItem			= 2,
	kShiftOptionModifierItem	= 3,
	kShiftOptCntlModifierItem	= 4,
	kCommandDeleteItem			= 5,
	kIconSuiteItem				= 6
};

enum
{
	kAboutSampleCmd			= 'abou',
	kCloseCmd				= 'clos',
	kQuitCmd				= 'quit',
	kOpenFinderWindowCmd	= 'opfw',
	kOpenDialogWindowCmd	= 'opdw',
	kOpenBevelDialogCmd		= 'opbd',
	kNewFeaturesDialogCmd	= 'newf',
	kStandardAlertCmd		= 'stal',
	kBevelImageAPICmd		= 'bvli',
	kCDEFTesterCmd			= 'cdef',
	kLiveFeedbackCmd		= 'live',
	kUtilityWindowCmd		= 'util',
	kSideUtilityWindowCmd	= 'side',
	kMegaDialogCmd			= 'mega',
	kAutoSizeCmd			= 'asiz',
	kVerticalZoomCmd		= 'vert',
	kHorizontalZoomCmd		= 'horz',
	kProxyPathDialogCmd		= 'prox'
};

enum
{
	kMenuTestAPI			= 148,
	kMenuDrawingTest		= 'mdra',
	kDumpHierarchy			= 'dhie',
	kHideMenu				= 'hmen',
	kDialogTimeouts			= 'dtim'
};

enum
{	
	kMenuCursors					= 149
};
	

//——————————————————————————————————————————————————————————————————————————————————
//	Prototypes
//——————————————————————————————————————————————————————————————————————————————————

static void		InitToolbox(void);
static void		MainEventLoop(void);

/* Event handling routines */

static void		HandleEvent(EventRecord *event);
static void		HandleActivate(EventRecord *event);
static void		HandleDiskInsert(EventRecord *event);
static void		HandleKeyPress(EventRecord *event);
static void 	HandleMouseDown(EventRecord *event);
static void		HandleOSEvent(EventRecord *event);
static void		HandleUpdate(EventRecord *event);

static void		AdjustMenus(void);
static void		HandleMenuCommand(long menuResult);

/* Utility routines */

static void		CloseAnyWindow(WindowPtr window);
static void		DeathAlert(short errorNumber);
static Boolean	IsAppWindow(WindowPtr window);
static Boolean 	IsDAWindow(WindowPtr window);
static Boolean	IsDialogWindow(WindowPtr window);

static Boolean	GetObjectFromWindow( WindowPtr window, BaseWindow** wind );
static void		SetUpFontMenu();
static void		SetUpModifiersMenu();
static void		DoAboutBox();

static void		AutoSizeDialogTest();
static void		SyncVertZoomRects( WindowPtr window );
static void		SyncHorizZoomRects( WindowPtr window );
static OSErr	GetReportFileSpec( FSSpecPtr file );

#if ENABLED_IN_CARBONLIB
static pascal Boolean		TimeoutFilter(DialogPtr theDialog, EventRecord *theEvent, DialogItemIndex *itemHit);
#endif

/* Custom Control Definition Stuff */

pascal SInt32 MyControlDefProc(	SInt16 varCode, ControlHandle theControl,
	ControlDefProcMessage message, SInt32 param);

pascal OSStatus MyControlCNTLToCollectionProc( const Rect * bounds, SInt16 value,
	Boolean visible, SInt16 max, SInt16 min, SInt16 procID, SInt32 refCon,
	ConstStr255Param title, Collection collection);

/* External routines */

extern void		TestStandardAlert();

extern "C" WindowRef OpenDoc( short, FSSpec *, StringPtr );

//———————————————————————————————————————————————————————————————————————————
//	Globals
//———————————————————————————————————————————————————————————————————————————


Boolean			gQuit;			/* 	We set this to TRUE when the user selects
									Quit from the File menu. Our main event loop
									exits gQuit is TRUE. */

Boolean			gInBackground;	/*	gInBackground is maintained by our osEvent
									handling routines. Any poart of the program
									can check it to find out if it is currently
									in the background. */

MenuHandle		gFontMenu = nil;		// Menu used to choose a font

#if ENABLED_IN_CARBONLIB
Boolean			gAnimateCursor = false; 
UInt32			gAnimationStep = 0;
ThemeCursor		gWhichCursor;
#endif 

//———————————————————————————————————————————————————————————————————————————
//	Macros
//———————————————————————————————————————————————————————————————————————————

#define	HiWrd(aLong)	(((aLong) >> 16) & 0xFFFF)
#define	LoWrd(aLong)	((aLong) & 0xFFFF)

//———————————————————————————————————————————————————————————————————————————
//	• main
//———————————————————————————————————————————————————————————————————————————
//	Entry point for our program. We initialize the Toolbox, make sure we are
//	running on a sufficiently brawny machine, and put up the menu bar. Finally,
//	we start polling for events and handling then by entering our main event
//	loop.
//	
int main( int /*argc*/, char** /*argv*/ )
{
	InitToolbox();					/*	Initialize the program */

	new MegaDialog();				/*	Create our initial window */

	MainEventLoop();					/* 	Call the main event loop */

	return 0;
}

/************************************************************
*    QuitAppleEventHandler()                                *
*                                                           *
*    Our quit Apple event handler.  This routine is called	*
*    when a quit Apple event is sent to our application.	*
*    Here, we set the gDoneFlag flag to true. NOTE:  it is	*
*    not appropriate to call ExitToShell here.  Instead,	*
*    by setting the flag to false we fall through the		*
*    bottom of our main loop and exit QuickTime gracefully	*
*************************************************************/

static pascal OSErr QuitAppleEventHandler( const AppleEvent *appleEvt, AppleEvent* reply, long refcon )
{
#pragma unused( appleEvt, reply, refcon )
	gQuit = true;
	return( noErr );
}


//———————————————————————————————————————————————————————————————————————————
//	• InitToolbox
//———————————————————————————————————————————————————————————————————————————
//	Set up the whole world, including global variables, Toolbox Managers, and
//	menus.
//	
static void
InitToolbox()
{
	SInt32						result;
	ControlDefSpec				defSpec;
	Handle						menuBar;
	MenuHandle					hierMenu;
	OSErr						err;
	MenuRef						menu;
	long						response;

	gInBackground = false;
	gQuit = false;

	InitCursor();

	// We have a custom control definition that we must
	// register with the Control Manager so it can get called
	// properly when it is used. We're registering this as
	// 'CDEF' 500.

	defSpec.defType = kControlDefProcPtr;
	defSpec.u.defProc = NewControlDefUPP( MyControlDefProc );
	RegisterControlDefinition( 500, &defSpec,
		NewControlCNTLToCollectionUPP( MyControlCNTLToCollectionProc ) );
		
	err = Gestalt( gestaltAppearanceAttr, &result );
	if ( err )
		DeathAlert( kNoAppearanceString );
		
	menuBar = GetNewMBar(rMenuBar);
	if ( menuBar == nil )
		DeathAlert( kResourceMissingString );
	
	// In order to get the theme-savvy menu bar, we need to call
	// RegisterAppearanceClient.

	// RegisterAppearanceClient();// not necessary as Carbon does this for us

	SetMenuBar(menuBar);

	hierMenu = GetMenu( kMenuCursors );
	if (hierMenu)
		InsertMenu(hierMenu, -1); // into the hierarchical portion of the menu list

	DisposeHandle(menuBar);
//	AppendResMenu(GetMenuHandle(mApple),'DRVR');
		
	err = Gestalt(gestaltMenuMgrAttr, &response);
	if ((err == noErr) && (response & gestaltMenuMgrAquaLayoutMask))
	{
		menu = GetMenuHandle( mFile );
		DeleteMenuItem( menu, iQuit );
		DeleteMenuItem( menu, iQuitSeperator );
	}

	err = AEInstallEventHandler( kCoreEventClass, kAEQuitApplication, NewAEEventHandlerUPP(QuitAppleEventHandler), 0, false );
	if (err != noErr)
	{
		ExitToShell();
	}

	SetUpFontMenu();

	SetUpModifiersMenu();
	
	AdjustMenus();

	DrawMenuBar();

}

//———————————————————————————————————————————————————————————————————————————
//	• MainEventLoop
//———————————————————————————————————————————————————————————————————————————
//	Get events and handle them by calling HandleEvent. On every event, we call
//	idle on the frontmost window, if there is one.
//	
static void
MainEventLoop()
{
	RgnHandle		cursorRgn;
	Boolean			gotEvent;
	EventRecord		event;
	WindowPtr		theWindow;
	BaseWindow*		window;
	
	cursorRgn = nil;
	while( !gQuit )
	{	
		gotEvent = WaitNextEvent( everyEvent, &event, 1, cursorRgn );
		if ( gotEvent )
		{
			HandleEvent( &event );
		}
#if ENABLED_IN_CARBONLIB
		else if (gAnimateCursor)
		{
			SetAnimatedThemeCursor(gWhichCursor,gAnimationStep);
			gAnimationStep++;
		}
#endif 		
		
		theWindow = FrontNonFloatingWindow();
		if ( theWindow && GetObjectFromWindow( theWindow, &window ) )
		{
			window->Idle();			
		}
	}
}

//———————————————————————————————————————————————————————————————————————————
//	• HandleEvent
//———————————————————————————————————————————————————————————————————————————
//	Do the right thing for an event. Determine what kind of event it is and
//	call the appropriate routines.
//
static void
HandleEvent( EventRecord *event )
{
	switch ( event->what )
	{
		case mouseDown:
			HandleMouseDown( event );
			break;
			
		case keyDown:
		case autoKey:
			HandleKeyPress( event );
			break;
			
		case activateEvt:
			HandleActivate( event );
			break;
			
		case updateEvt:
			HandleUpdate( event );
			break;
			
		case kHighLevelEvent:
			AEProcessAppleEvent( event );
			break;

		case diskEvt:
			HandleDiskInsert( event );
			break;
			
		case osEvt:
			HandleOSEvent( event );
			break;
	}
}

//———————————————————————————————————————————————————————————————————————————
//	• HandleActivate
//———————————————————————————————————————————————————————————————————————————
//	This is called when a window is activated or deactivated. In this sample,
//	the Window Manager's handling of activate and deactivate events is
//	sufficient. Others applications may have TextEdit records, controls, lists,
//	etc., to activate/deactivate.
//
static void
HandleActivate( EventRecord *event )
{
	WindowPtr		theWindow;
	Boolean			becomingActive;
	BaseWindow*		windObj;
	
	theWindow = (WindowPtr)event->message;
	becomingActive = (event->modifiers & activeFlag) != 0;

	if ( IsDialogWindow( theWindow ) )
	{
		DialogRef		dialog;
		SInt16			itemHit;

		DialogSelect( event, &dialog, &itemHit );
	}
	else if ( GetObjectFromWindow( theWindow, &windObj ) )
	{
		if ( becomingActive )
			windObj->Activate( *event );
		else
			windObj->Deactivate( *event );
	}
}

//———————————————————————————————————————————————————————————————————————————
//	• HandleDiskInsert
//———————————————————————————————————————————————————————————————————————————
//	Called when we get a disk-inserted event. Check the upper word of the
//	event message; if it's nonzero, then a bad disk was inserted, and it
//	needs to be formatted.
//	
static void
HandleDiskInsert( EventRecord *event )
{
	Point		aPoint = {100, 100};
	
	if ( HiWrd( event->message ) != noErr )
	{
	//	DIBadMount( aPoint, event->message );
	}
}

//———————————————————————————————————————————————————————————————————————————
//	• HandleKeyPress
//———————————————————————————————————————————————————————————————————————————
//	The user pressed a key, what are you going to do about it?
//
static void
HandleKeyPress( EventRecord *event )
{
	char		key;
	
	key = event->message & charCodeMask;
	if ( event->modifiers & cmdKey )
	{
		AdjustMenus();

		//**************************************************************************//
		//	APPEARANCE ADOPTION ALERT!!												//
		//**************************************************************************//
		// Here we use the new MenuEvent routine instead of menu key. This allows
		// us to handle extended modifier keys for the menu items that use them.
		
		HandleMenuCommand( MenuEvent( event ) );
	}
	else
	{
		WindowPtr 	window = FrontNonFloatingWindow();
		BaseWindow*	object;
		
		if ( window && GetObjectFromWindow( window, &object ) )
		{
			object->HandleKeyDown( *event );
		}
	}
}

//———————————————————————————————————————————————————————————————————————————
//	• HandleMouseDown
//———————————————————————————————————————————————————————————————————————————
//	Called to handle mouse clicks. The user could have clicked anywhere,so
//	let's first find out where by calling FindWindow. That returns a number
//	indicating where in the screen the mouse was clicked. "switch" on that
//	number and call the appropriate routine.
//
static void
HandleMouseDown( EventRecord *event )
{
	long		newSize;
	Rect		growRect;
	WindowPtr	theWindow;
	short		part;
	BitMap		screenBits;

	part = FindWindow( event->where, &theWindow );
	
	switch ( part )
	{
		case inMenuBar:
			AdjustMenus();
			HandleMenuCommand( MenuSelect( event->where ) );
			break;
			
		case inSysWindow:
	//		SystemClick( event, theWindow );
			break;
			
		case inContent:
			if ( theWindow != FrontNonFloatingWindow() )
			{
				SelectWindow( theWindow );
			}
			else
			{
				BaseWindow* 	wind;
				
				if ( GetObjectFromWindow( theWindow, &wind ) )
					wind->HandleClick( *event );
			}
			break;
			
		case inDrag:
			if ( GetWindowKind( theWindow ) != kObjectWindowKind )
			{
                DragWindow( theWindow, event->where, &GetQDGlobalsScreenBits( &screenBits )->bounds );
			}
			else
				{
					BaseWindow*		wind;
					
					if ( GetObjectFromWindow( theWindow, &wind ) )
						wind->DoDragClick(event);
				}				
				
            if ( GetWindowKind( theWindow ) == kHorizZoomKind )
				SyncHorizZoomRects( theWindow );
            else if ( GetWindowKind( theWindow ) == kVertZoomKind )
				SyncVertZoomRects( theWindow );
			break;
			
		case inGrow:
            growRect = GetQDGlobalsScreenBits( &screenBits )->bounds;
			growRect.top = growRect.left = 80;
			newSize = GrowWindow(theWindow,event->where,&growRect);
			if (newSize != 0)
			{
				BaseWindow*		wind;
				
				if ( GetObjectFromWindow( theWindow, &wind ) )
					wind->Resize( LoWrd(newSize), HiWrd(newSize) );
				else
					SizeWindow( theWindow, LoWrd( newSize ), HiWrd( newSize ), true );
			}
			break;
			
		case inGoAway:
			if (TrackGoAway(theWindow,event->where))
				CloseAnyWindow(theWindow);
			break;

		case inProxyIcon:
#if ENABLED_IN_CARBONLIB
			HandleProxyDrag(theWindow, event);
#endif			
			break;
			
		case inZoomIn:
		case inZoomOut:
			if ( TrackBox( theWindow, event->where, part ) )
			{
				CGrafPtr		port = GetWindowPort( theWindow );
				Rect			portRect;

				SetPort( port );
				EraseRect( GetPortBounds( port, &portRect ) );
				ZoomWindow( theWindow, part, true );
				InvalWindowRect( theWindow, &portRect );
			}
			break;
	}
}

//———————————————————————————————————————————————————————————————————————————
//	• HandleOSEvent
//———————————————————————————————————————————————————————————————————————————
//	Deal with OSEvents. These are messages that the process manager sends to
//	us. Here, we deal with the suspend and resume message.
//	
static void
HandleOSEvent( EventRecord *event )
{
	WindowPtr		window;

	switch( (event->message >> 24) & 0x00FF )
	{
		case suspendResumeMessage:
		
				// In our SIZE resource, we say that we are MultiFinder aware.
				// This means that we take on the responsibility of activating
				// and deactivating our own windows on suspend/resume events. */

			gInBackground = (event->message & resumeFlag) == 0;

			window = FrontNonFloatingWindow();
		
			if ( window )
			{
				BaseWindow*		wind;
				
				if ( GetObjectFromWindow( window, &wind ) )
				{
					if ( gInBackground )
						wind->Deactivate( *event );
					else
						wind->Activate( *event );
				}
			}
			break;
			
		case mouseMovedMessage:
			break;
	}
}

//———————————————————————————————————————————————————————————————————————————
//	• HandleUpdate
//———————————————————————————————————————————————————————————————————————————
//	This is called when an update event is received for a window. It calls
//	DoUpdateWindow to draw the contents of an application window. As an
//	efficiency measure that does not have to be followed, it calls the drawing
//	routine only if the visRgn is nonempty. This will handle situations where
//	calculations for drawing or drawing itself is very time consuming.
//	
static void
HandleUpdate( EventRecord *event )
{
	 WindowPtr			theWindow = (WindowPtr)event->message;
	 BaseWindow*		wind;
	 
	if ( IsDialogWindow( theWindow ) )
	{
		DialogRef		dialog;
		SInt16			itemHit;

		DialogSelect( event, &dialog, &itemHit );
	}
	else if ( GetObjectFromWindow( theWindow, &wind ) )
	{
		RgnHandle		region = NewRgn();
		
		if ( region )
		{
            GetPortVisibleRegion( GetWindowPort( theWindow ), region );

            if ( !EmptyRgn( region ) )
            {
                SetPort( GetWindowPort( theWindow ) );
                wind->Update( *event );
            }
            DisposeRgn( region );
		}
	}
	else
	{
		BeginUpdate( theWindow );
		EndUpdate( theWindow );
	}
}

//———————————————————————————————————————————————————————————————————————————
//	• AdjustMenus
//———————————————————————————————————————————————————————————————————————————
//	Enable and disable menus based on the currene state. The user can only 
//	select enabled menu items. We set up all the menu items before calling
//	MenuSelect or MenuKey, since these are the only times that a menu item can
//	be selected. Note that MenuSelect is also the only time the user will see
//	menu items. This approach to deciding what enable/disable state a menu
//	item has has the advantage of concentrating all the decision making in one
//	routine, as opposed to being spread throughout the application. Other
//	application designs may take a different approach that is just as valid.
//	
static void
AdjustMenus()
{
	WindowPtr		theWindow;
	MenuHandle		menu;
	BaseWindow*		wind;
	
	theWindow = FrontNonFloatingWindow();
	
	menu = GetMenuHandle( mFile );

	if ( theWindow )
		EnableMenuItem( menu, iClose );
	else
		DisableMenuItem( menu, iClose );

	if ( theWindow && GetObjectFromWindow( theWindow, &wind ) )
	{
		wind->AdjustMenus();
	}
}

#if ENABLED_IN_CARBONLIB
//
// Simply displays an alert using StandardAlert that reminds the user about how to 
// bring the titlebar back.  An exercise for the reader is implementing a system
// whereby the menubar is hidden, but comes back temporarily when the mouse moves into the
// menubar region.
static void
DoMenuAlert(void)
{
	AlertStdAlertParamRec myAlertRec = {false, false, nil, (unsigned char *)-1, nil, nil, kAlertStdAlertOKButton,0,kWindowDefaultPosition};
	SInt16 ignoreHit;
										
	StandardAlert(kAlertPlainAlert, "\pAfter this dialog goes away, typing command-H will bring the menubar back", "\p", &myAlertRec, &ignoreHit);
	HideMenuBar();
}

static pascal Boolean
TimeoutFilter(DialogPtr theDialog, EventRecord * /*theEvent*/, DialogItemIndex * /*itemHit*/)
{
	static Boolean firstTime = true;
	OSStatus returnValue;
	SInt16 whichButton;
	UInt32 secondsToWait,secondsRemaining;
	static UInt32 oldSecondsRemaining = 5;
	
	if (GetDialogTimeout(theDialog, &whichButton, &secondsToWait, &secondsRemaining) == dialogNoTimeoutErr)
	// this is the first time through so set up the timeout
		{
		 	SetDialogTimeout(theDialog, kAlertStdAlertOKButton, 10); // 10 seconds, not ticks.
		 	oldSecondsRemaining = 5;
		}
		
	returnValue = GetDialogTimeout(theDialog, &whichButton, &secondsToWait, &secondsRemaining);

	if (returnValue == noErr)
		{
			if  (secondsRemaining != oldSecondsRemaining)  // don't redraw too often or it flickers
				{
					Str255 theString;
					DialogItemType ignoreType;
					Rect ignoreRect;
					Handle staticTextItem;
					
					GetDialogItem(theDialog, 3, &ignoreType, &staticTextItem, &ignoreRect);
					
					NumToString(secondsRemaining, theString);
					SetDialogItemText(staticTextItem, theString);
					oldSecondsRemaining = secondsRemaining; // save for next time through
					firstTime = false;
				}
		}
	
	return(false);
}


//
// DoDialogTimeouts simply brings up a modal dialog with a static text item in it.  The
// filter proc above uses SetDialogTimeout and GetDialogTimeout to show how these 
// routines can be used to have auto-dismissing dialogs.
//
static void
DoDialogTimeouts(void)
{
	SInt16 ignoreHit;
	ModalFilterUPP myModalFilter = NewModalFilterProc(TimeoutFilter);
	DialogPtr myDialog = GetNewDialog(3000,nil,(WindowPtr) -1);
	
	if (!myDialog)
		return;

	ModalDialog(myModalFilter,&ignoreHit);
	
	DisposeDialog(myDialog);
	DisposeRoutineDescriptor(myModalFilter);
}	

#endif


//
// DoCursorMenu is just a silly little way of showing how SetThemeCursor can be used..  It just takes
// a cursor selector, which we're getting based upon which menu item was chosen.
// 

#if ENABLED_IN_CARBONLIB
static void 
DoCursorMenu(short menuItem)
{
	gWhichCursor = menuItem - 1;
	
	if ((gWhichCursor >= kThemeArrowCursor) && (gWhichCursor <= kThemeResizeLeftRightCursor))
		{
			SetThemeCursor(gWhichCursor);
			
			if ((gWhichCursor == kThemeWatchCursor) || 
			   ((gWhichCursor >= kThemeCountingUpHandCursor) && (gWhichCursor <= kThemeSpinningCursor)))
			   {
			   		gAnimateCursor = true;
			   		gAnimationStep = 0; // reset
			   }
		}
}
#endif		

		
//———————————————————————————————————————————————————————————————————————————
//	• HandleMenuCommand
//———————————————————————————————————————————————————————————————————————————
//	This is called when an item is chosen from the menu bar (after calling
//	MenuSelect or MenuKey). It performs the right operation for each command.
//	It tries to get the command ID of the menu item selected. If it can't, or
//	the command is unknown, we pass it on to the front window, if any. We
//	also special case the Apple menu items.
//	
static void
HandleMenuCommand( long menuResult )
{
	short		menuID;
	short		menuItem;
	Str255		daName;
	UInt32		command;
	Boolean		handled;
	OSErr		err;
	WindowPtr	window;
	
	menuID = HiWrd( menuResult );
	menuItem = LoWrd( menuResult );

	err = GetMenuItemCommandID( GetMenuHandle( menuID ), menuItem, &command );

	handled = false;
	
	if ( err || command == 0 )
	{
		if ( menuID == mApple )
		{
			GetMenuItemText( GetMenuHandle( mApple ), menuItem, daName );
//			OpenDeskAcc( daName );
			handled = true;
		}
	}
	else
	{
		handled = true;
		switch( command )
		{
			case kAboutSampleCmd:
				DoAboutBox();
				break;
			
			case kCloseCmd:
				if ( FrontNonFloatingWindow() )
					CloseAnyWindow( FrontNonFloatingWindow() );
				break;
			
			case kQuitCmd:
				gQuit = true;
				break;

			case kOpenFinderWindowCmd:
				new FinderWindow();
				break;
				
			case kOpenDialogWindowCmd:
				new DialogWindow();
				break;
			
			case kOpenBevelDialogCmd:
				new BevelDialog();
				break;
			
			case kBevelImageAPICmd:
				new BevelImageAPIWindow();
				break;
				
			case kCDEFTesterCmd:
				new CDEFTester();
				break;
			
			case kStandardAlertCmd:
				TestStandardAlert();
				break;
			
			case kLiveFeedbackCmd:
				new LiveFeedbackDialog();
				break;
			
			case kUtilityWindowCmd:
				new UtilityWindow();
				break;
			
			case kSideUtilityWindowCmd:
				new SideUtilityWindow();
				break;
			
			case kMegaDialogCmd:
				new MegaDialog();
				break;
			
			case kAutoSizeCmd:
				AutoSizeDialogTest();
				break;
			
			case kVerticalZoomCmd:
				window = GetNewWindow( 133, nil, (WindowPtr)-1L );
				if ( window )
				{
					SetWindowKind( window, kVertZoomKind );
					SetWindowPic( window, GetPicture( 133 ) );
					SyncVertZoomRects( window );
				}
				break;
			
			case kHorizontalZoomCmd:
				window = GetNewWindow( 134, nil, (WindowPtr)-1L );
				if ( window )
				{
					SetWindowKind( window, kHorizZoomKind );
					SetWindowPic( window, GetPicture( 134 ) );
					SyncHorizZoomRects( window );
				}
				break;
			
			case kProxyPathDialogCmd:
#if ENABLED_IN_CARBONLIB
				new ProxyDialog(2019);
#endif				
				break;
			
			case kMenuDrawingTest:
				DrawMenuStuff();
				break;
			
			case kDumpHierarchy:
				if ( FrontNonFloatingWindow() )
				{
					FSSpec		file;
					
					GetReportFileSpec( &file );
					DumpControlHierarchy( FrontNonFloatingWindow(), &file );
				}
				break;
			
			case kHideMenu:
#if ENABLED_IN_CARBONLIB
				if (IsMenuBarVisible())
					DoMenuAlert();
				else
				ShowMenuBar();
#endif
				break;
			
			case kDialogTimeouts:
#if ENABLED_IN_CARBONLIB
				DoDialogTimeouts();
#endif				
				break;

			default:
				handled = false;
				break;
					
		}

#if ENABLED_IN_CARBONLIB		
		if (menuID == kMenuCursors)
		{
			DoCursorMenu(menuItem);
			handled = true;
		}
#endif

	}
	
	if ( !handled )
	{
		WindowPtr 	frontWindow = FrontNonFloatingWindow();
		BaseWindow* wind;
		
		if ( frontWindow )
		{
			if ( GetObjectFromWindow( frontWindow, &wind ) )
			{
				wind->HandleMenuSelection( menuID, menuItem );
			}
		}
	}

	HiliteMenu(0);
}

//———————————————————————————————————————————————————————————————————————————
//	• CloseAnyWindow
//———————————————————————————————————————————————————————————————————————————
//	Close the given window in a manner appropriate for that window. If the
//	window belongs to a DA, we call CloseDeakAcc. For dialogs, we simply hide
//	the window. If we had any document windows, we would probably call either
//	DisposeWindow or CloseWindow after disposing of any document data and/or
//	controls.
//	
static void
CloseAnyWindow( WindowPtr window )
{
	BaseWindow*		wind;
	
	if ( IsDAWindow( window ) )
	{
		// CloseDeskAcc( ((WindowPeek)window)->windowKind );
	}
	else if ( GetObjectFromWindow( window, &wind ) )
	{
		delete wind;
	}
	else
		DisposeWindow( window );
}

//———————————————————————————————————————————————————————————————————————————
//	• DeathAlert
//———————————————————————————————————————————————————————————————————————————
//	Display an alert that tell the user an err occurred, then exit the
//	program. This routine is used as an ultimate bail-out for serious errors
//	that prohibit the continuation of the application. The error number is
//	used to index an 'STR#' resource so that a relevant message can be
//	displayed.
//
static void
DeathAlert( short errNumber )
{
	short			itemHit;
	Str255			theMessage;
	Cursor			arrow;
	
	SetCursor( GetQDGlobalsArrow( &arrow ) );
	GetIndString( theMessage, kErrorStrings, errNumber );
	ParamText( theMessage, nil, nil, nil );
	itemHit = StopAlert( kAlertStartupError, nil );
	ExitToShell();
}

//———————————————————————————————————————————————————————————————————————————
//	• IsAppWindow
//———————————————————————————————————————————————————————————————————————————
//	Check to see if a window belongs to the application. If the window
//	pointer passed was NIL, then it could not be an application window.
//	WindowKinds that are negative belong to the system and windowKinds
//	less that userKind are reserved by Apple except for userKinds equal to
//	dialogKind, which means it's a dialog.
//	

static Boolean
IsAppWindow( WindowPtr window )
{
	short		windowKind;
	
	if ( window == nil )
		return false;
		
	windowKind = GetWindowKind( window );
	return( (windowKind >= userKind) || (windowKind == dialogKind) );
}

//———————————————————————————————————————————————————————————————————————————
//	• IsDAWindow
//———————————————————————————————————————————————————————————————————————————
//	Check to see if a window belongs to a desk accessory. It belongs to a DA
//	if the windowKind field of the window record is negative.
//	
static Boolean
IsDAWindow( WindowPtr window )
{
	if ( window == nil )
		return false;

    return( GetWindowKind( window ) < 0 );
}

//———————————————————————————————————————————————————————————————————————————
//	• IsDialogWindow
//———————————————————————————————————————————————————————————————————————————
//	Check to see if a window is a dialog window. We can determine this by
//	checking to see if the windowKind field is equal to dialogKind.
//
static Boolean
IsDialogWindow( WindowPtr window )
{
	if ( window == nil )
		return false;

    return( GetWindowKind( window ) == dialogKind );
}

//———————————————————————————————————————————————————————————————————————————
//	• GetObjectFromWindow
//———————————————————————————————————————————————————————————————————————————
//	Gets the object pointer from the refCon of the given window if the kind
//	is right. If the kind is wrong, or the refCon is null, we return false.
//
static Boolean
GetObjectFromWindow( WindowPtr window, BaseWindow** wind )
{
	SInt32		test;
	
    if ( GetWindowKind( window ) != kObjectWindowKind )
		return false;
		
	test = GetWRefCon( window );
	if ( test == nil ) return false;
	
	*wind = (BaseWindow*)test;

	return true;
}

//———————————————————————————————————————————————————————————————————————————
//	• SetUpFontMenu
//———————————————————————————————————————————————————————————————————————————
//	This routine calls AddResMenu to add all fonts to our font menu. We then
//	go thru each item and set the item's font to the actual font!
//
static void
SetUpFontMenu()
{
	SInt16			i, numItems;
	Str255			fontName;
	SInt16			fontNum;
	
	gFontMenu = GetMenu( kMenuFonts );
	if ( gFontMenu == nil ) return;
	
	AppendResMenu( gFontMenu, 'FONT' );
	
	numItems = CountMenuItems( gFontMenu );
	for ( i = 1; i <= numItems; i++ )
	{
		GetMenuItemText( gFontMenu, i, fontName );
		GetFNum( fontName, &fontNum );
		SetMenuItemFontID( gFontMenu, i, fontNum );
	}	
	InsertMenu(gFontMenu,0);

	DisableMenuItem(gFontMenu,0);
}

//———————————————————————————————————————————————————————————————————————————
//	• SetUpModifiersMenu
//———————————————————————————————————————————————————————————————————————————
//	This routine programmatically sets the modifiers for our modifier menu.
//
static void
SetUpModifiersMenu()
{
	MenuHandle		menu;
	Handle			suite;
	OSErr			err;
	
	menu = GetMenuHandle( kMenuModifiers );
	if ( menu == nil ) return;

	SetMenuItemModifiers( menu, kShiftModifierItem, kMenuShiftModifier );	
	SetMenuItemModifiers( menu, kShiftOptionModifierItem, kMenuShiftModifier + kMenuOptionModifier );	
	SetMenuItemModifiers( menu, kShiftOptCntlModifierItem, kMenuShiftModifier + kMenuOptionModifier + kMenuControlModifier );	

	SetItemCmd( menu, kCommandDeleteItem, 0x08 ); // delete key

	SetMenuItemKeyGlyph( menu, kCommandDeleteItem, 0x17 ); // delete key glyph in font
	
	err = GetIconSuite( &suite, -3997, kSelectorAllAvailableData );
	if ( err == noErr )
		SetMenuItemIconHandle( menu, kIconSuiteItem, kMenuIconSuiteType, suite );

	// The rest of the items in this large menu show the various special characters that can be used in menus.
	// They are set up when the menu is created by the data in the corresponding xmnu resource
}

//———————————————————————————————————————————————————————————————————————————
//	• DoAboutBox
//———————————————————————————————————————————————————————————————————————————
//	Puts up our about box dialog. Note that we use a dialog and NOT an alert.
//	This is a good practice to get into, since alerts are now colored differently
//	to distiguish them from normal dialogs.
//
static void
DoAboutBox()
{
	DialogPtr		dialog;
	SInt16			itemHit;
	
	dialog = GetNewDialog( kAboutBoxDialogID, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return;

	SetDialogDefaultItem( dialog, 4 );	
	ModalDialog( nil, &itemHit );
	
	DisposeDialog( dialog );
}

//————————————————————————————————————————————————————————————————————————————
//	• AutoSizeDialogTest
//————————————————————————————————————————————————————————————————————————————
//	Simple little routine to demonstrate the AutoSizeDialog API
//
static void
AutoSizeDialogTest()
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	
	dialog = GetNewDialog( 4000, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return;
	
	SetDialogDefaultItem( dialog, 2 );
	
	while ( itemHit != 2 )
	{
		ModalDialog( nil, &itemHit );

		if ( itemHit == 3 )
			AutoSizeDialog( dialog );
	}
	DisposeDialog( dialog );
}

//————————————————————————————————————————————————————————————————————————————
//	• SyncVertZoomRects
//————————————————————————————————————————————————————————————————————————————
//	Sets up the standard and user rectangles for our vertical zooming window.
//
static void
SyncVertZoomRects( WindowPtr window )
{
	Rect		bounds;
	CGrafPtr	port;
	
	port = GetWindowPort( window );

    SetPort( port );
	GetPortBounds( port, &bounds );
	
	if ( (bounds.bottom - bounds.top) < 200 )
		bounds.bottom = bounds.top + 200;
		
	LocalToGlobal( &topLeft( bounds ) );
	LocalToGlobal( &botRight( bounds ) );
	
	SetWindowStandardState( window, &bounds );
	
	bounds.bottom = bounds.top + 60;
	SetWindowUserState( window, &bounds );
}

//————————————————————————————————————————————————————————————————————————————
//	• SyncHorizZoomRects
//————————————————————————————————————————————————————————————————————————————
//	Sets up the standard and user rectangles for our horizontal zooming window.
//
static void
SyncHorizZoomRects( WindowPtr window )
{
	Rect		bounds;
    CGrafPtr	port;

    port = GetWindowPort( window );

    SetPort( port );
    GetPortBounds( port, &bounds );

	if ( (bounds.right - bounds.left) < 240 )
		bounds.right = bounds.left + 240;
		
	LocalToGlobal( &topLeft( bounds ) );
	LocalToGlobal( &botRight( bounds ) );
	
	SetWindowStandardState( window, &bounds );
	
	bounds.right = bounds.left + 60;
	SetWindowUserState( window, &bounds );
}

//————————————————————————————————————————————————————————————————————————————
//	• GetReportFileSpec
//————————————————————————————————————————————————————————————————————————————
//	Returns our file spec for dumping pane information.
//
static OSErr
GetReportFileSpec( FSSpecPtr file )
{
	FCBPBRec	pb;
	Str255		ourName;
	OSErr		err;
	
	pb.ioVRefNum	= -1;
	pb.ioFCBIndx	= 0;
	pb.ioNamePtr	= ourName;
	pb.ioRefNum		= CurResFile();
	
	err = PBGetFCBInfoSync( &pb );
	if ( err ) return err;
	
	err = FSMakeFSSpec( pb.ioFCBVRefNum, pb.ioFCBParID, "\pPane Dump", file );
	return err;
}

//————————————————————————————————————————————————————————————————————————————
//	• MyControlCNTLToCollectionProc
//————————————————————————————————————————————————————————————————————————————
//	All controls are now created through a new API (CreateNewCustomControl)
//	which does not take explicit value, min, max, refCon, or other parameters.
//	Instead, it takes a Collection which can have all of that information
//	along with any special info which is unique to each Control Definition.
//	Unfortunately, calls to NewControl and GetNewControl only have access to
//	the basic value, min, max information. Because those pieces of information
//	might be overloaded to have a special meaning for our Control Definition,
//	the Control Manager needs to know how to translate that data into the right
//	tagged Collection data. We have registered this routine to do the
//	translation for our custom Control Definition.
//
pascal OSStatus MyControlCNTLToCollectionProc( const Rect * bounds, SInt16 value,
	Boolean visible, SInt16 max, SInt16 min, SInt16 procID, SInt32 refCon,
	ConstStr255Param title, Collection collection)
{
#pragma unused (procID)

	OSStatus		err = noErr;
	SInt32		value32 = value;
	SInt32		max32 = max;
	SInt32		min32 = min;

	// The value, min, etc. do not get overloaded into special meanings for us,
	// so we can simply add each one to the collection with the standard Control
	// Collection Tags. The Control Manager will recognize these standard tags
	// and will give their values to the control instance.

	err = AddCollectionItem( collection, kControlCollectionTagBounds, 0,
		sizeof( Rect ), (void*)bounds );
	if ( err != noErr ) goto CantAddCollectionItem;

	err = AddCollectionItem( collection, kControlCollectionTagValue, 0,
		sizeof( SInt32 ), &value32 );
	if ( err != noErr ) goto CantAddCollectionItem;

	err = AddCollectionItem( collection, kControlCollectionTagVisibility, 0,
		sizeof( Boolean ), &visible );
	if ( err != noErr ) goto CantAddCollectionItem;

	err = AddCollectionItem( collection, kControlCollectionTagMaximum, 0,
		sizeof( SInt32 ), &max32 );
	if ( err != noErr ) goto CantAddCollectionItem;

	err = AddCollectionItem( collection, kControlCollectionTagMinimum, 0,
		sizeof( SInt32 ), &min32 );
	if ( err != noErr ) goto CantAddCollectionItem;

	err = AddCollectionItem( collection, kControlCollectionTagRefCon, 0,
		sizeof( SInt32 ), &refCon );
	if ( err != noErr ) goto CantAddCollectionItem;

	err = AddCollectionItem( collection, kControlCollectionTagTitle, 0,
		title[0], (void*)&title[1] );
	if ( err != noErr ) goto CantAddCollectionItem;

CantAddCollectionItem:
	
	return err;
}

//————————————————————————————————————————————————————————————————————————————
//	• MyControlDefProc
//————————————————————————————————————————————————————————————————————————————
//	The entrypoint for our custom Control Definition.
//	We can and must do all of the stuff that we would have done within a
//	'CDEF' resource.
//
//	This particular Control Definition simply draws its title within the
//	control's bounds.
//
pascal SInt32 MyControlDefProc(	SInt16 varCode, ControlHandle theControl,
	ControlDefProcMessage message, SInt32 param)
{
#pragma unused (varCode)

	SInt32 				result = 0;
	Rect				bounds;
	Str255				title;
	GrafPtr				currentPort;
	ThemeDrawingState	state;
	SInt16				savedFont;
	Style				savedFace;
	SInt16				savedMode;
	SInt16				savedSize;
	RgnHandle			region;

	GetControlBounds( theControl, &bounds );
	GetControlTitle( theControl, title );

	switch ( message ) {
		case drawCntl:
			// prepare to draw in the current port
			GetPort( &currentPort );
			savedFont = GetPortTextFont( currentPort );
			savedFace = GetPortTextFace( currentPort );
			savedMode = GetPortTextMode( currentPort );
			savedSize = GetPortTextSize( currentPort );
			GetThemeDrawingState( &state );
			NormalizeThemeDrawingState();
			UseThemeFont( kThemeSystemFont, smSystemScript );

			// just draw our title within our bounding box
			TETextBox( &title[1], title[0], &bounds, teFlushDefault );

			// restore what we did to the port
			SetThemeDrawingState( state, true );
			TextFont( savedFont );
			TextFace( savedFace );
			TextMode( savedMode );
			TextSize( savedSize );
			break;

		case testCntl:
			// we are display only, so we don't track
			result = kControlNoPart;
			break;

		case initCntl:
			// we don't do any special work during initialization
			// and we return noErr as an indication that initialization
			// was successful.
			result = noErr;
			break;

		case dispCntl:
			// we don't have to do any work
			break;

		case calcCntlRgn:
			// this Control Definition is as big as its bounds
			region = (RgnHandle)param;
			RectRgn( region, &bounds );
			break;

		case kControlMsgGetFeatures:
			// we have no features
			result = 0;
			break;

		case kControlMsgTestNewMsgSupport:
			// we support the new messages, so return
			// the appropriate value
			result = kControlSupportsNewMessages;
			break;

		default:
			break;
	}

	return result;
}

