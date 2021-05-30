/*
	File:		InlineInputSample.c

	Contains:	C source file for InlineInputSample

	Copyright:	© 1989-1994 Apple Computer, Inc. All rights reserved.

*/


/* Segmentation strategy:

   There isn't any. Depending on which compiler you use, and whether you build for
   Mac-OS 68K, A/UX, or PowerPC, segments may look different or not exist at all.
   And with an application this small, segments don't really matter any more these
   days. So we don't try to figure out segmentation and segment unloading strategies.
   If you want to find out how to segment your application, look at some other
   sample code.
*/


/* SetPort strategy:

   Toolbox routines do not change the current port. In spite of this, in this
   program we use a strategy of calling SetPort whenever we want to draw or
   make calls which depend on the current port. This makes us less vulnerable
   to bugs in other software which might alter the current port (such as the
   bug (feature?) in many desk accessories which change the port on OpenDeskAcc).
   Hopefully, this also makes the routines from this program more self-contained,
   since they don't depend on the current port setting.
*/


/* Clipboard strategy:

   Under styled TextEdit, TECut and TECopy will write both the text and associated
   style information directly to the desk scrap as types 'TEXT' and 'styl'.
   Instead of using TEToScrap and TEFromScrap, a new routine TEStylPaste, will 
   transfer the text and style from the desk scrap to the document.
*/


#if qInline
#define qAppleEvents 1
#endif


#include <Limits.h>
#include <Types.h>
#include <QuickDraw.h>
#include <Fonts.h>
#include <Controls.h>
#include <ControlDefinitions.h>
#include <Windows.h>
#include <TextEdit.h>
#include <Dialogs.h>
#include <Menus.h>
#include <Devices.h>
#include <Events.h> 
#include <Scrap.h>
#include <TextUtils.h>
#include <ToolUtils.h>
#include <MacMemory.h>
#include <Processes.h>
#include <Files.h>
#include <OSUtils.h>
#include <Packages.h>
#include <Traps.h>
#include <Printing.h>
#include <DiskInit.h>
#include <FCntl.h>
#include <MacRuntime.h>
#include <StringCompare.h>

#if qAppleEvents
#include <Errors.h>
#include <Gestalt.h>
#include <AppleEvents.h>
#if qInline
#include <TextServices.h>
#include <Script.h>
#include "TSMTE.h"
#endif // qInline
#endif // qAppleEvents

#include "InlineInputSample.h"


// Constants

// top left corner of the disk initialization dialog

const short kDITop = 80;
const short kDILeft = 112;

// the number of pixels we leave blank at the edge of the window

const short kTextMargin = 2;

// the maximum number of open documents at any one time. SetupMenus respects this
// number, but the Apple event handlers don't.

const short kMaxOpenDocuments = 4;
	
// arbitrary number used to specify the width of the TERec's destination
// rectangle so that word wrap and horizontal scrolling can be demonstrated

const short kMaxDocWidth = 576;
	
// the minimum dimension of a window for GrowWindow

const short kMinDocDim = 64;

// control contrlVis values to prevent or enable redrawing controls by
// Control Manager routines such as SetCtlValue

const unsigned char kControlInvisible = 0;
const unsigned char kControlVisible = 0xff;

// for calculating scroll bar positions and sizes

const short kScrollbarWidth = 16;
const short kScrollbarAdjust = 15; // should be kScrollbarWidth - 1, but C is too stupid
const short kScrollTweek = 2;
	
// ASCII code for delete character

const unsigned char kDelChar = 8;
	
// pixels to scroll when the button part of the horizontal scrollbar is pressed

const short kButtonScroll = 4;

// maximum text length we allow in a TERec; lower than 32767 to prevent errors

const short kMaxTELength = 32000;

// the SysEnvRec version we understand

const short kSysEnvironsVersion = 1;

// events mask for no events

const short kNoEventsMask = 0;

// the minimum heap size and minimal available heap space we require for running.
// These are rough guesses; with styled TextEdit and printing you never really know.

const Size kMinHeap = 50 * 1024;
const Size kMinSpace = 40 * 1024;

// values for setting up wide open rectangles and regions

const short kExtremeNeg = -32768;
const short kExtremePos = 32767 -1; // required to address an old region bug

// extra security when pre-flighting edit commands

const short kTESlop = 1024;


// Types

// A DocumentRecord contains the WindowRecord for one of our document windows,
// as well as the TEHandle for the text we are editing. Other document fields
// can be added to this record as needed. This is similar to how the
// Window Manager and Dialog Manager add fields after the GrafPort.

typedef struct {
	WindowRecord	docWindow;
	TEHandle		docTE;
	ControlHandle	docVScroll;
	ControlHandle	docHScroll;
	TEClickLoopUPP	docClick;
	Boolean			modified;
#if qInline
	TSMTERecHandle	docTSMTERecHandle;
	TSMDocumentID	docTSMDoc;
#endif
} DocumentRecord, *DocumentPeek;


// Global Variables

// environment information that's set up during initialization

Boolean gHasWaitNextEvent;		// WaitNextEvent trap is available
#if qAppleEvents
Boolean gHasAppleEvents;		// Apple events are available, so we expect to get events from the Finder
#if qInline
Boolean gHasTextServices;		// Text Services Manager is available and should be used
Boolean gHasTSMTE;				// Text Services for Text Edit are available and should be used
								// gHasTSMTE can only be set if gHasTextServices.
#endif // qInline
#endif // qAppleEvents

// whether we are currently in the background. This accounts for major switches only.

Boolean gInBackground;

// the number of documents currently open

short gNumDocuments;

// print record shared among all documents ??? probably should be attached to documents instead

THPrint gPrinterRecord;

// universal procedure pointers

ControlActionUPP gHActionUPP;
ControlActionUPP gVActionUPP;
#if powerc
TEClickLoopUPP gClickLoopUPP;
#endif
#if qAppleEvents
AEEventHandlerUPP gHandleOAppUPP;
AEEventHandlerUPP gHandleDocUPP;
AEEventHandlerUPP gHandleQuitUPP;
#if qInline
TSMTEPreUpdateUPP gTSMTEPreUpdateUPP;
TSMTEPostUpdateUPP gTSMTEPostUpdateUPP;
#endif // qInline
#endif // qAppleEvents

QDGlobals qd;

#if qAppleEvents
// to indicate that Quit command or Apple event was successful

Boolean gQuitting;

#if qInline
// variable to keep outside fontForce information

long gSavedFontForce;

#endif // qInline
#endif // qAppleEvents


// Routine Declarations

void AlertUser(short error);
void EventLoop(void);
void DoEvent(EventRecord *event);
void AdjustCursor(Point mouse, RgnHandle region);
void GetGlobalMouse(Point *mouse);
void DoGrowWindow(WindowPtr window, EventRecord *event);
void DoZoomWindow(WindowPtr window, short part);
void ResizedWindow(WindowPtr window);
void GetLocalUpdateRgn(WindowPtr window, RgnHandle localRgn);
void DoUpdate(WindowPtr window);
void DoActivate(WindowPtr window, Boolean becomingActive);
void DoContentClick(WindowPtr window, EventRecord *event);
void DoKeyDown(EventRecord *event);
unsigned long GetSleep(void);
void CommonAction(ControlHandle control, short *amount);
pascal void VActionProc(ControlHandle control, short part);
pascal void HActionProc(ControlHandle control, short part);
void DoIdle(void);
void DrawWindow(WindowPtr window);
void AdjustMenus(void);
void DoMenuCommand(long menuResult);
void DoNew(void);
Boolean DoCloseWindow(WindowPtr window);
#if qAppleEvents
static void PrepareToQuit(void);
#else // qAppleEvents
static void Terminate(void);
#endif // qAppleEvents
void Initialize(void);
void BigBadError(short error);
static void FailNilUPP(UniversalProcPtr theUPP);
void GetTERect(WindowPtr window, Rect *teRect);
void AdjustViewRect(TEHandle docTE);
void AdjustTE(WindowPtr window);
void AdjustHV(Boolean isVert, ControlHandle control, TEHandle docTE, Boolean canRedraw);
void AdjustScrollValues(WindowPtr window, Boolean canRedraw);
void AdjustScrollSizes(WindowPtr window);
void AdjustScrollbars(WindowPtr window, Boolean needsResize);
#if powerc
pascal Boolean ClickLoopProc(TEPtr pTE);
#else
extern pascal void AsmClickLoopProc(void);
#endif
pascal void ClickLoopAddOn(void);
pascal TEClickLoopUPP GetOldClickLoop(void);
Boolean IsDocumentWindow(WindowPtr window);
Boolean IsDAWindow(WindowPtr window);
static void PrintText(TEHandle theText);
#if qAppleEvents
static void CheckAppleEvents(void);
static OSErr InstallRequiredAppleEvents(void);
static OSErr GotRequiredParameters(const AppleEvent *theAppleEvent);
pascal OSErr HandleOAppEvent(const AppleEvent *theEvent, const AppleEvent *reply, long refCon);
pascal OSErr HandleDocEvent(const AppleEvent *theEvent, const AppleEvent *reply, long refCon);
pascal OSErr HandleQuitEvent(const AppleEvent *theEvent, const AppleEvent *reply, long refCon);
#if qInline
static void CheckForTextServices(void);
static pascal void MyTSMTEPreUpdateProc(TEHandle textH, long refCon);
static pascal void MyTSMTEPostUpdateProc(TEHandle textH, long fixLen, long inputAreaStart,
			long inputAreaEnd, long pinStart, long pinEnd, long refCon);
static void ExitApplication(void);
#endif // qInline
#endif // qAppleEvents



// Set up the whole world, including global variables, Toolbox managers.
// If a problem occurs here, we alert the user and exit from the application.

void Initialize(void)
{
	EventRecord event;
	short count;
	SysEnvRec systemEnvironment;
	long total, contig;
	Handle menuBar;

	gInBackground = false;
#if qAppleEvents
	gQuitting = false;
#endif // qAppleEvents

	InitGraf((Ptr) &qd.thePort);
	InitFonts();
	InitWindows();
	InitMenus();
	TEInit();
	InitDialogs(nil);
	InitCursor();

	// the following loop is necessary to allow the default button of our
	// alert to be outlined. We use EventAvail instead of GetNextEvent so we
	// don't lose events.
	
	for (count = 1; count <= 3; count++)
		EventAvail(everyEvent, &event);
	
	// collect environment information

	// ignore the error returned from SysEnvirons; even if an error occurred,
	// the SysEnvirons glue will fill in the SysEnvRec.
	 
	SysEnvirons(kSysEnvironsVersion, &systemEnvironment);
	
	// make sure that the machine has at least 128K ROMs. If it doesn't, exit.
	
	if (systemEnvironment.machineType < 0)
		BigBadError(eOldROM);
	
	// also, require at least system 6.0. The app should be able to run on system
	// software 4.1 (where styled TextEdit was introduced) and later, but it's not really
	// worth the trouble of testing on all those old systems anymore.
	
	if (systemEnvironment.systemVersion < 0x600)
		BigBadError(eOldSystemSoftware);
	
	// It is better to first check the size of the application heap against a value
	// that you have determined is the smallest heap the application can reasonably
	// work in. This number should be derived by examining the size of the heap that
	// is actually provided by MultiFinder when the minimum size requested is used.
	// The check should be made because the preferred size can end up being set smaller
	// than the minimum size by the user. This extra check acts to insure that your
	// application is starting from a solid memory foundation.
	 
	if ((long) GetApplLimit() - (long) ApplicationZone() < kMinHeap)
		BigBadError(eSmallSize);
	
	// Next, make sure that enough memory is free for your application to run. It
	// is possible for a situation to arise where the heap may have been of required
	// size, but a large scrap was loaded which left too little memory. To check for
	// this, call PurgeSpace and compare the result with a value that you have determined
	// is the minimum amount of free memory your application needs at initialization.
	// This number can be derived several different ways. One way that is fairly
	// straightforward is to run the application in the minimum size configuration
	// as described previously. Call PurgeSpace at initialization and examine the value
	// returned. However, you should make sure that this result is not being modified
	// by the scrap's presence. You can do that by calling ZeroScrap before calling
	// PurgeSpace. Make sure to remove that call before shipping, though.
	
	// ZeroScrap();

	PurgeSpace(&total, &contig);
	if (total < kMinSpace)
		if (UnloadScrap() != noErr)
			BigBadError(eNoMemory);
		else
		{
			PurgeSpace(&total, &contig);
			if (total < kMinSpace)
				BigBadError(eNoMemory);
		};

	// The extra benefit to waiting until after the Toolbox Managers have been initialized
	// to check memory is that we can now give the user an alert to tell him/her what
	// happened. Although it is possible that the memory situation could be worsened by
	// displaying an alert, MultiFinder would gracefully exit the application with
	// an informative alert if memory became critical. Here we are acting more
	// in a preventative manner to avoid future disaster from low-memory problems.

	// check for newer system services and set up our environment to make use of what's available.
	
	gHasWaitNextEvent = TrapAvailable(_WaitNextEvent);

#if qAppleEvents
	CheckAppleEvents();
	if (gHasAppleEvents)
		(void) InstallRequiredAppleEvents();
#if qInline

	CheckForTextServices();
	
	// this application uses TextEdit as the only text engine, and we don't support
	// inline input without TSMTE. Therefore we call InitTSMAwareApplication only if
	// TSMTE is available. A word processor that uses TextEdit only for dialogs
	// and uses Text Services directly with the word processing engine would make this
	// call depend on gHasTextServices.
	
	if (!(gHasTSMTE && InitTSMAwareApplication() == noErr))
	{
		// if this happens, just move on without text services
		gHasTextServices = false;
		gHasTSMTE = false;
	};
	
	// get global fontForce flag, make sure it's off whenever we run
	
	gSavedFontForce = GetScriptManagerVariable(smFontForce);
	(void) SetScriptManagerVariable(smFontForce, 0);
#endif // qInline
#endif // qAppleEvents

	// set up the menu bar and the menus that depend on the system environment
	
	menuBar = GetNewMBar(rMenuBar);	
	if ( menuBar == nil )
		BigBadError(eNoMemory);
	SetMenuBar(menuBar);
	DisposeHandle(menuBar);
	AppendResMenu(GetMenuHandle(mApple), 'DRVR');	// build the Apple menu
	AppendResMenu(GetMenuHandle(mFont), 'FONT');	// build the Font menu
	DrawMenuBar();

	// we have no document open yet
	
	gNumDocuments = 0;

	// set up printer stuff - this will allow the default page setup parameters to be used,
	// so if the user decides to print without using the Page Setup command everything will
	// be OK
	
	gPrinterRecord = (THPrint) NewHandle(sizeof(TPrint));
	if (gPrinterRecord != nil)
	{
		// if we got a print handle, initialize it to default values
		PrOpen();
		PrintDefault(gPrinterRecord);
		PrClose();
	};
	
	// initialize the universal procedure pointers that we need
#if qAppleEvents
	// (Apple event handler UPPs are set up in InstallRequiredAppleEvents)
#endif // qAppleEvents
	
	gHActionUPP = NewControlActionProc(HActionProc);
	FailNilUPP((UniversalProcPtr) gHActionUPP);
	gVActionUPP = NewControlActionProc(VActionProc);
	FailNilUPP((UniversalProcPtr) gVActionUPP);
#if powerc
	gClickLoopUPP = NewTEClickLoopProc(ClickLoopProc);
	FailNilUPP((UniversalProcPtr) gClickLoopUPP);
#endif
#if qInline
	if (gHasTSMTE)
	{
		gTSMTEPreUpdateUPP = NewTSMTEPreUpdateProc(MyTSMTEPreUpdateProc);
		FailNilUPP((UniversalProcPtr) gTSMTEPreUpdateUPP);
		gTSMTEPostUpdateUPP = NewTSMTEPostUpdateProc(MyTSMTEPostUpdateProc);
		FailNilUPP((UniversalProcPtr) gTSMTEPostUpdateUPP);
	};
#endif // qInline
}


// report a fatal error to the user and exit from the application

void BigBadError(short error)
{
	AlertUser(error);
#if qInline
	ExitApplication();
#else // qInline
	ExitToShell();
#endif // qInline
}


// check whether a valid UPP was allocated

static void FailNilUPP(UniversalProcPtr theUPP)
{
	if (theUPP == nil)
		BigBadError(eNoMemory);
}

#if qAppleEvents

// check to see if a given bit in a long word is set.

static Boolean BTst(long value, short bit)
{
	long mask = 1L << bit;
	
	return (value & mask) == mask;
}

#endif // qAppleEvents


#if qAppleEvents

static void CheckAppleEvents(void)
{
	long gestaltResponse;
	
	gHasAppleEvents = false;
	
	if (TrapAvailable(_Gestalt))
	{
		if (Gestalt(gestaltAppleEventsAttr, &gestaltResponse) == noErr)
			gHasAppleEvents = BTst(gestaltResponse, gestaltAppleEventsPresent);
	};
}

#if qInline

// check whether the Text Services Manager and the extension for using Text Services with
// TextEdit (TSMTE) are available, and sets gHasTextServices and gHasTSMTE accordingly.

static void CheckForTextServices(void)
{
	long gestaltResponse;
	
	gHasTextServices = false;		// unless proven otherwise
	gHasTSMTE = false;				// unless proven otherwise
	
	if (TrapAvailable(_Gestalt))
	{
		if ((Gestalt(gestaltTSMgrVersion, &gestaltResponse) == noErr) && (gestaltResponse >= 1))
		{
			gHasTextServices = true;
			if (Gestalt(gestaltTSMTEAttr, &gestaltResponse) == noErr)
				gHasTSMTE = BTst(gestaltResponse, gestaltTSMTEPresent);
		};
	};
}

#endif // qInline
#endif // qAppleEvents

void main(void)
{
	/*	If you have stack requirements that differ from the default,
		then you could use SetApplLimit to increase StackSpace at 
		this point, before calling MaxApplZone. */
	MaxApplZone();					/* expand the heap */

	Initialize();					/* initialize the program */
#if qAppleEvents
	if (!gHasAppleEvents)
		DoNew();
#else // qAppleEvents
	DoNew();
#endif // qAppleEvents

	EventLoop();					/* call the main event loop */

#if qAppleEvents
#if qInline
	ExitApplication();
#else // qInline
	ExitToShell();
#endif // qInline
#endif // qAppleEvents
}

#if qInline

static Boolean IntlTSMEvent(EventRecord *event)
{
	short oldFont;
	ScriptCode keyboardScript;
	
	// make sure we have a port and it's not the Window Manager port
	if (qd.thePort != nil && FrontWindow() != nil)
	{
		oldFont = qd.thePort->txFont;
		keyboardScript = GetScriptManagerVariable(smKeyScript);
		if (FontToScript(oldFont) != keyboardScript)
			TextFont(GetScriptVariable(keyboardScript, smScriptAppFond));
	};
	return TSMEvent(event);
}

#endif // qInline

/* Get events forever, and handle them by calling DoEvent.
   Also call AdjustCursor each time through the loop. */

void EventLoop(void)
{
	RgnHandle	cursorRgn;
	Boolean		gotEvent;
	EventRecord	event;
	Point		mouse;

	cursorRgn = NewRgn();			/* we’ll pass WNE an empty region the 1st time thru */
#if qAppleEvents
	while (!gQuitting)
#else // qAppleEvents
	while (true) // loop forever, quit via ExitToShell
#endif // qAppleEvents
	{
#if qInline
		// set global fontForce flag so other apps don't get confused
		(void) SetScriptManagerVariable(smFontForce, gSavedFontForce);
		
#endif // qInline
		/* use WNE if it is available */
		if ( gHasWaitNextEvent ) {
			GetGlobalMouse(&mouse);
			AdjustCursor(mouse, cursorRgn);
			gotEvent = WaitNextEvent(everyEvent, &event, GetSleep(), cursorRgn);
		}
		else {
			SystemTask();
			gotEvent = GetNextEvent(everyEvent, &event);
		};

#if qInline
		// clear fontForce again so it doesn't upset our operations
		gSavedFontForce = GetScriptManagerVariable(smFontForce);
		(void) SetScriptManagerVariable(smFontForce, 0);
		
		if ( gotEvent && !(gHasTextServices && IntlTSMEvent(&event)))
#else // qInline
		if ( gotEvent )
#endif
		{
			/* make sure we have the right cursor before handling the event */
			AdjustCursor(event.where, cursorRgn);
			DoEvent(&event);
		}
		else
			DoIdle();				/* perform idle tasks when it’s not our event */
		/*	If you are using modeless dialogs that have editText items,
			you will want to call IsDialogEvent to give the caret a chance
			to blink, even if WNE/GNE returned FALSE. However, check FrontWindow
			for a non-NIL value before calling IsDialogEvent. */
	};
}


/* Do the right thing for an event. Determine what kind of event it is, and call
 the appropriate routines. */

void DoEvent(EventRecord *event)
{
	short		part, err;
	WindowPtr	window;
	char		key;
	Point		aPoint;
#if qInline
	long		menuResult;
#endif // qInline

	switch ( event->what ) {
		case nullEvent:
			/* we idle for null/mouse moved events ands for events which aren’t
				ours (see EventLoop) */
			DoIdle();
			break;
		case mouseDown:
			part = FindWindow(event->where, &window);
			switch ( part ) {
				case inMenuBar:             /* process a mouse menu command (if any) */
					AdjustMenus();
#if qInline
					menuResult = MenuSelect(event->where);
					if (!(gHasTextServices && TSMMenuSelect(menuResult)))
						DoMenuCommand(menuResult);
					HiliteMenu(0); // needed even if TSM or Script Manager handle the menu
#else // qInline
					DoMenuCommand(MenuSelect(event->where));
#endif // qInline
					break;
				case inSysWindow:           /* let the system handle the mouseDown */
					SystemClick(event, window);
					break;
				case inContent:
					if ( window != FrontWindow() ) {
						SelectWindow(window);
						AdjustMenus();
					} else
						DoContentClick(window, event);
					break;
				case inDrag:                /* pass screenBits.bounds to get all gDevices */
					DragWindow(window, event->where, &qd.screenBits.bounds);
					break;
				case inGoAway:
					if ( TrackGoAway(window, event->where) )
						DoCloseWindow(window); /* we don’t care if the user cancelled */
					break;
				case inGrow:
					DoGrowWindow(window, event);
					break;
				case inZoomIn:
				case inZoomOut:
				if ( TrackBox(window, event->where, part) )
						DoZoomWindow(window, part);
					break;
			}
			break;
		case keyDown:
		case autoKey:                       /* check for menukey equivalents */
			key = event->message & charCodeMask;
			if ( event->modifiers & cmdKey ) {	/* Command key down */
				if ( event->what == keyDown ) {
					AdjustMenus();			/* enable/disable/check menu items properly */
					DoMenuCommand(MenuKey(key));
				}
			} else
				DoKeyDown(event);
			break;
		case activateEvt:
			DoActivate((WindowPtr) event->message, (event->modifiers & activeFlag) != 0);
			break;
		case updateEvt:
			DoUpdate((WindowPtr) event->message);
			break;
		/*	1.01 - It is not a bad idea to at least call DIBadMount in response
			to a diskEvt, so that the user can format a floppy. */
		case diskEvt:
			if ( HiWord(event->message) != noErr ) {
				SetPt(&aPoint, kDILeft, kDITop);
				err = DIBadMount(aPoint, event->message);
			}
			break;
		case osEvt:
		/*	1.02 - must BitAND with 0x0FF to get only low byte */
			switch ((event->message >> 24) & 0x0FF) {		/* high byte of message */
				case mouseMovedMessage:
					DoIdle();					/* mouse-moved is also an idle event */
					break;
				case suspendResumeMessage:		/* suspend/resume is also an activate/deactivate */
					gInBackground = (event->message & resumeFlag) == 0;
					DoActivate(FrontWindow(), !gInBackground);
					break;
			}
			break;
#if qAppleEvents
		case kHighLevelEvent:
			if (AEProcessAppleEvent(event) != noErr)
				; // any ideas for error handling?
			break;
#endif // qAppleEvents
	}
} /*DoEvent*/


/*	Change the cursor's shape, depending on its position. This also calculates the region
	where the current cursor resides (for WaitNextEvent). When the mouse moves outside of
	this region, an event is generated. If there is more to the event than just
	“the mouse moved”, we get called before the event is processed to make sure
	the cursor is the right one. In any (ahem) event, this is called again before we
	fall back into WNE. */

void AdjustCursor(Point mouse, RgnHandle region)
{
	WindowPtr	window;
	RgnHandle	arrowRgn;
	RgnHandle	iBeamRgn;
	Rect		iBeamRect;

	window = FrontWindow();	/* we only adjust the cursor when we are in front */
	if ( (! gInBackground) && (! IsDAWindow(window)) ) {
		/* calculate regions for different cursor shapes */
		arrowRgn = NewRgn();
		iBeamRgn = NewRgn();

		/* start arrowRgn wide open */
		SetRectRgn(arrowRgn, kExtremeNeg, kExtremeNeg, kExtremePos, kExtremePos);

		/* calculate iBeamRgn */
		if ( IsDocumentWindow(window) ) {
			iBeamRect = (*((DocumentPeek) window)->docTE)->viewRect;
			SetPort(window);	/* make a global version of the viewRect */
			// ??? following two lines depend on Rect structure layout
			LocalToGlobal((Point *) &(iBeamRect).top);
			LocalToGlobal((Point *) &(iBeamRect).bottom);
			RectRgn(iBeamRgn, &iBeamRect);
			/* we temporarily change the port’s origin to “globalfy” the visRgn */
			SetOrigin(-window->portBits.bounds.left, -window->portBits.bounds.top);
			SectRgn(iBeamRgn, window->visRgn, iBeamRgn);
			SetOrigin(0, 0);
		}

		/* subtract other regions from arrowRgn */
		DiffRgn(arrowRgn, iBeamRgn, arrowRgn);

#if qInline
		// before we commit to anything, let's check whether some text service has a
		// different idea
		
		if (!(gHasTextServices && SetTSMCursor(mouse)))
		{
			// change the cursor and the region parameter
			if (PtInRgn(mouse, iBeamRgn))
			{
				SetCursor(*GetCursor(iBeamCursor));
				CopyRgn(iBeamRgn, region);
			}
			else
			{
				SetCursor(&qd.arrow);
				CopyRgn(arrowRgn, region);
			};
		};

		// and no matter how nice the region, with text services it cannot be bigger than
		// a point. Yes, this defeats the purpose of all the calculations...
		
		if (gHasTextServices)
			SetRectRgn(region, mouse.h, mouse.v, mouse.h, mouse.v);
#else // qInline
		// change the cursor and the region parameter
		if (PtInRgn(mouse, iBeamRgn))
		{
			SetCursor(*GetCursor(iBeamCursor));
			CopyRgn(iBeamRgn, region);
		}
		else
		{
			SetCursor(&qd.arrow);
			CopyRgn(arrowRgn, region);
		};
#endif // qInline

		DisposeRgn(arrowRgn);
		DisposeRgn(iBeamRgn);
	}
} /*AdjustCursor*/


/*	Get the global coordinates of the mouse. When you call OSEventAvail
	it will return either a pending event or a null event. In either case,
	the where field of the event record will contain the current position
	of the mouse in global coordinates and the modifiers field will reflect
	the current state of the modifiers. Another way to get the global
	coordinates is to call GetMouse and LocalToGlobal, but that requires
	being sure that thePort is set to a valid port. */

void GetGlobalMouse(Point *mouse)
{
	EventRecord	event;
	
	OSEventAvail(kNoEventsMask, &event);	/* we aren't interested in any events */
	*mouse = event.where;				/* just the mouse position */
} /*GetGlobalMouse*/


/*	Called when a mouseDown occurs in the grow box of an active window. In
	order to eliminate any 'flicker', we want to invalidate only what is
	necessary. Since ResizedWindow invalidates the whole portRect, we save
	the old TE viewRect, intersect it with the new TE viewRect, and
	remove the result from the update region. However, we must make sure
	that any old update region that might have been around gets put back. */

void DoGrowWindow(WindowPtr window, EventRecord *event)
{
	long		growResult;
	Rect		tempRect;
	RgnHandle	tempRgn;
	DocumentPeek doc;
	
	tempRect = qd.screenBits.bounds;					/* set up limiting values */
	tempRect.left = kMinDocDim;
	tempRect.top = kMinDocDim;
	growResult = GrowWindow(window, event->where, &tempRect);
	/* see if it really changed size */
	if ( growResult != 0 ) {
		doc = (DocumentPeek) window;
		tempRect = (*doc->docTE)->viewRect;				/* save old text box */
		tempRgn = NewRgn();
		GetLocalUpdateRgn(window, tempRgn);				/* get localized update region */
		SizeWindow(window, LoWord(growResult), HiWord(growResult), true);
		ResizedWindow(window);
		/* calculate & validate the region that hasn’t changed so it won’t get redrawn */
		SectRect(&tempRect, &(*doc->docTE)->viewRect, &tempRect);
		ValidRect(&tempRect);							/* take it out of update */
		InvalRgn(tempRgn);								/* put back any prior update */
		DisposeRgn(tempRgn);
	}
} /* DoGrowWindow */


/* 	Called when a mouseClick occurs in the zoom box of an active window.
	Everything has to get re-drawn here, so we don't mind that
	ResizedWindow invalidates the whole portRect. */

void DoZoomWindow(WindowPtr window, short part)
{
	EraseRect(&window->portRect);
	ZoomWindow(window, part, window == FrontWindow());
	ResizedWindow(window);
} /*  DoZoomWindow */


/* Called when the window has been resized to fix up the controls and content. */
void ResizedWindow(WindowPtr window)
{
	AdjustScrollbars(window, true);
	AdjustTE(window);
	InvalRect(&window->portRect);
} /* ResizedWindow */


/* Returns the update region in local coordinates */
void GetLocalUpdateRgn(WindowPtr window, RgnHandle localRgn)
{
	CopyRgn(((WindowPeek) window)->updateRgn, localRgn);	/* save old update region */
	OffsetRgn(localRgn, window->portBits.bounds.left, window->portBits.bounds.top);
} /* GetLocalUpdateRgn */


/*	This is called when an update event is received for a window.
	It calls DrawWindow to draw the contents of an application window.
	As an efficiency measure that does not have to be followed, it
	calls the drawing routine only if the visRgn is non-empty. This
	will handle situations where calculations for drawing or drawing
	itself is very time-consuming. */

void DoUpdate(WindowPtr window)
{
	if ( IsDocumentWindow(window) ) {
		BeginUpdate(window);				/* this sets up the visRgn */
		if ( ! EmptyRgn(window->visRgn) )	/* draw if updating needs to be done */
			DrawWindow(window);
		EndUpdate(window);
	}
} /*DoUpdate*/


/*	This is called when a window is activated or deactivated.
	It calls TextEdit to deal with the selection. */

void DoActivate(WindowPtr window, Boolean becomingActive)
{
	RgnHandle	tempRgn, clipRgn;
	Rect		growRect;
	DocumentPeek doc;
	
	if ( IsDocumentWindow(window) ) {
		doc = (DocumentPeek) window;
		if ( becomingActive ) {
			/*	since we don’t want TEActivate to draw a selection in an area where
				we’re going to erase and redraw, we’ll clip out the update region
				before calling it. */
			tempRgn = NewRgn();
			clipRgn = NewRgn();
			GetLocalUpdateRgn(window, tempRgn);			/* get localized update region */
			GetClip(clipRgn);
			DiffRgn(clipRgn, tempRgn, tempRgn);			/* subtract updateRgn from clipRgn */
			SetClip(tempRgn);
			TEActivate(doc->docTE);
			SetClip(clipRgn);							/* restore the full-blown clipRgn */
			DisposeRgn(tempRgn);
			DisposeRgn(clipRgn);
			
			/* the controls must be redrawn on activation: */
			(*doc->docVScroll)->contrlVis = kControlVisible;
			(*doc->docHScroll)->contrlVis = kControlVisible;
			InvalRect(&(*doc->docVScroll)->contrlRect);
			InvalRect(&(*doc->docHScroll)->contrlRect);
			/* the growbox needs to be redrawn on activation: */
			growRect = window->portRect;
			/* adjust for the scrollbars */
			growRect.top = growRect.bottom - kScrollbarAdjust;
			growRect.left = growRect.right - kScrollbarAdjust;
			InvalRect(&growRect);
#if qInline
			if (doc->docTSMDoc != nil)
				(void) ActivateTSMDocument(doc->docTSMDoc);
#endif // qInline
		}
		else
		{		
#if qInline
			if (doc->docTSMDoc != nil)
				(void) DeactivateTSMDocument(doc->docTSMDoc);
#endif // qInline
			TEDeactivate(doc->docTE);
			/* the controls must be hidden on deactivation: */
			HideControl(doc->docVScroll);
			HideControl(doc->docHScroll);
			/* the growbox should be changed immediately on deactivation: */
			DrawGrowIcon(window);
		}
	}
} /*DoActivate*/


/*	This is called when a mouseDown occurs in the content of a window. */

void DoContentClick(WindowPtr window, EventRecord *event)
{
	Point		mouse;
	ControlHandle control;
	short		part, value;
	Boolean		shiftDown;
	DocumentPeek doc;
	Rect		teRect;

	if ( IsDocumentWindow(window) ) {
		SetPort(window);
		mouse = event->where;							/* get the click position */
		GlobalToLocal(&mouse);
		doc = (DocumentPeek) window;
		/* see if we are in the viewRect. if so, we won’t check the controls */
		GetTERect(window, &teRect);
		if ( PtInRect(mouse, &teRect) ) {
			/* see if we need to extend the selection */
			shiftDown = (event->modifiers & shiftKey) != 0;	/* extend if Shift is down */
			TEClick(mouse, shiftDown, doc->docTE);
		} else {
			part = FindControl(mouse, window, &control);
			switch ( part ) {
				case 0:							/* do nothing for viewRect case */
					break;
				case kControlIndicatorPart:
					value = GetControlValue(control);
					part = TrackControl(control, mouse, nil);
					if ( part != 0 ) {
						value -= GetControlValue(control);
						/* value now has CHANGE in value; if value changed, scroll */
						if ( value != 0 )
							if ( control == doc->docVScroll )
								TEScroll(0, value, doc->docTE);
							else
								TEScroll(value, 0, doc->docTE);
					}
					break;
				default:						/* they clicked in an arrow, so track & scroll */
					if ( control == doc->docVScroll )
						value = TrackControl(control, mouse, gVActionUPP);
					else
						value = TrackControl(control, mouse, gHActionUPP);
					break;
			}
		}
	}
} /*DoContentClick*/


/* This is called for any keyDown or autoKey events, except when the
 Command key is held down. It looks at the frontmost window to decide what
 to do with the key typed. */

void DoKeyDown(EventRecord *event)
{
	enum { minArrowKey = 28, maxArrowKey = 31 };

	WindowPtr	window;
	char		key;
	TEHandle	te;

	window = FrontWindow();
	if ( IsDocumentWindow(window) ) {
		te = ((DocumentPeek) window)->docTE;
		key = event->message & charCodeMask;
		/* we have a char. for our window; see if we are still below TextEdit’s
			limit for the number of characters (but deletes are always rad) */
		if ( key == kDelChar ||
				(*te)->teLength - ((*te)->selEnd - (*te)->selStart) + 1 <
				kMaxTELength )
		{
			TEKey(key, te);
			if ((key < minArrowKey) || (key > maxArrowKey)) // not a cursor key
				((DocumentPeek) window)->modified = true;
			AdjustScrollbars(window, false);
		}
		else
			AlertUser(eExceedChar);
	}
} /*DoKeyDown*/


/*	Calculate a sleep value for WaitNextEvent. This takes into account the things
	that DoIdle does with idle time. */

unsigned long GetSleep(void)
{
	long		sleep;
	WindowPtr	window;
	TEHandle	te;

	sleep = LONG_MAX;						/* default value for sleep */
	if ( !gInBackground ) {
		window = FrontWindow();			/* and the front window is ours... */
		if ( IsDocumentWindow(window) ) {
			te = ((DocumentPeek) (window))->docTE;	/* and the selection is an insertion point... */
			if ( (*te)->selStart == (*te)->selEnd )
				sleep = GetCaretTime();		/* blink time for the insertion point */
		}
	}
	return sleep;
} /*GetSleep*/


/*	Common algorithm for pinning the value of a control. It returns the actual amount
	the value of the control changed. Note the pinning is done for the sake of returning
	the amount the control value changed. */

void CommonAction(ControlHandle control, short *amount)
{
	short		value, max;
	
	value = GetControlValue(control);	/* get current value */
	max = GetControlMaximum(control);		/* and maximum value */
	*amount = value - *amount;
	if ( *amount < 0 )
		*amount = 0;
	else if ( *amount > max )
		*amount = max;
	SetControlValue(control, *amount);
	*amount = value - *amount;		/* calculate the real change */
} /* CommonAction */


/* Determines how much to change the value of the vertical scrollbar by and how
	much to scroll the TE record. */

pascal void VActionProc(ControlHandle control, short part)
{
	short		amount;
	WindowPtr	window;
	TEPtr		te;
	
	if ( part != 0 ) {				/* if it was actually in the control */
		window = (*control)->contrlOwner;
		te = *((DocumentPeek) window)->docTE;
		switch ( part ) {
			case kControlUpButtonPart:
			case kControlDownButtonPart:
				amount = 24;
				break;
			case kControlPageUpPart:			/* one page */
			case kControlPageDownPart:
				amount = te->viewRect.bottom - te->viewRect.top;
				break;
		}
		if ( (part == kControlDownButtonPart) || (part == kControlPageDownPart) )
			amount = -amount;		/* reverse direction for a downer */
		CommonAction(control, &amount);
		if ( amount != 0 )
			TEScroll(0, amount, ((DocumentPeek) window)->docTE);
	}
} /* VActionProc */


/* Determines how much to change the value of the horizontal scrollbar by and how
much to scroll the TE record. */

pascal void HActionProc(ControlHandle control, short part)
{
	short		amount;
	WindowPtr	window;
	TEPtr		te;
	
	if ( part != 0 ) {
		window = (*control)->contrlOwner;
		te = *((DocumentPeek) window)->docTE;
		switch ( part ) {
			case kControlUpButtonPart:
			case kControlDownButtonPart:		/* a few pixels */
				amount = kButtonScroll;
				break;
			case kControlPageUpPart:			/* a page */
			case kControlPageDownPart:
				amount = te->viewRect.right - te->viewRect.left;
				break;
		}
		if ( (part == kControlDownButtonPart) || (part == kControlPageDownPart) )
			amount = -amount;		/* reverse direction */
		CommonAction(control, &amount);
		if ( amount != 0 )
			TEScroll(amount, 0, ((DocumentPeek) window)->docTE);
	}
} /* VActionProc */


/* This is called whenever we get a null event et al.
 It takes care of necessary periodic actions. For this program, it calls TEIdle. */

void DoIdle(void)
{
	WindowPtr	window;

	window = FrontWindow();
	if ( IsDocumentWindow(window) )
		TEIdle(((DocumentPeek) window)->docTE);
} /*DoIdle*/


/* Draw the contents of an application window. */

void DrawWindow(WindowPtr window)
{
	SetPort(window);
	EraseRect(&window->portRect);
	DrawControls(window);
	DrawGrowIcon(window);
	TEUpdate(&window->portRect, ((DocumentPeek) window)->docTE);
} /*DrawWindow*/


// menu handling utilities

static void DisableMenu(MenuHandle menu)
{
	DisableItem(menu, 0);
}


static void EnableMenu(MenuHandle menu)
{
	EnableItem(menu, 0);
}

static void RemoveMenuCheckMarks(MenuHandle menu)
{
	short item;

	for (item = 1; item <= CountMItems(menu); item++)
	{
		CheckItem(menu, item, false);
	};
}

static void RemoveMenuStyles(MenuHandle menu)
{
	short item;

	for (item = 1; item <= CountMItems(menu); item++)
	{
		SetItemStyle(menu, item, normal);
	};
}

static void EnableItemIf(MenuHandle menu, short item, Boolean condition)
{
	if (condition)
		EnableItem(menu, item);
	else
		DisableItem(menu, item);
}


// enable and disable menus based on the current state.
// In general, we set up the menu items only before calling MenuSelect or MenuKey,
// since these are the only times that a menu item can be selected. However, we
// also have to set up the menus whenever the front window changes because
// we enable and disable some menu titles depending on the front window.

void AdjustMenus(void)
{
	WindowPtr	window;
	Boolean		frontIsDAWindow;
	Boolean		frontIsDocWindow;
	Boolean		docHasSelection;
	Boolean		clipboardHasText;
	Boolean		haveContinuousFont;
	MenuHandle	menu;
	long		offset;
	TEHandle	te;
	TextStyle	theTextStyle;
	short		theFont;
	short		mode;
	short		item;
	

	// gather some state information that we'll need to decide which menu items to enable
	window = FrontWindow();
	frontIsDAWindow = (window != nil) && IsDAWindow(window);
	frontIsDocWindow = (window != nil) && IsDocumentWindow(window);
	if (frontIsDocWindow)
	{
		te = ((DocumentPeek) window)->docTE;
		docHasSelection = (*te)->selStart < (*te)->selEnd;
	}
	else
		docHasSelection = false;
	clipboardHasText = GetScrap(nil, 'TEXT', &offset)  > 0;
		// note that TEGetScrapLength works for the private TextEdit scrap only, which
		// is not used by styled TextEdit
	haveContinuousFont = false; // will really be set when setting up font menu
	
	// Apple menu is always enabled
	
	// File menu
	menu = GetMenuHandle(mFile);
	EnableItemIf(menu, iNew, gNumDocuments < kMaxOpenDocuments);
	EnableItemIf(menu, iClose, window != nil);
	EnableItemIf(menu, iPageSetup, frontIsDocWindow);
	EnableItemIf(menu, iPrint, frontIsDocWindow);
	EnableItem(menu, iQuit);

	menu = GetMenuHandle(mEdit);
	EnableItemIf(menu, iUndo, frontIsDAWindow); // can't handle Undo for documents yet
	EnableItemIf(menu, iCut, frontIsDAWindow || docHasSelection);
	EnableItemIf(menu, iCopy, frontIsDAWindow || docHasSelection);
	EnableItemIf(menu, iPaste, frontIsDAWindow || (frontIsDocWindow && clipboardHasText));
	EnableItemIf(menu, iClear, frontIsDAWindow || docHasSelection);
	EnableItemIf(menu, iSelectAll, frontIsDocWindow);
	
	menu = GetMenuHandle(mFont);
	RemoveMenuCheckMarks(menu);
	if (frontIsDocWindow)
	{
		EnableMenu(menu);

		mode = doFont;
		if (TEContinuousStyle(&mode, &theTextStyle, ((DocumentPeek) window)->docTE))
		{
			Str255 theName, itemName;
			short itemCount;
			
			GetFontName(theTextStyle.tsFont, theName);
			itemCount = CountMItems(menu);
			for (item = 1; item <= itemCount; item++)
			{
				GetMenuItemText(menu, item, itemName);
				if (EqualString(theName, itemName, true, true))
				{
					CheckItem(menu, item, true);
					break;
				};
			};
			
			haveContinuousFont = true;
			theFont = theTextStyle.tsFont;
		};
	}
	else
	{
		DisableMenu(menu);
	};
	
	menu = GetMenuHandle (mFontSize);
	RemoveMenuCheckMarks(menu);
	RemoveMenuStyles(menu);
	if (frontIsDocWindow)
	{
		EnableMenu(menu);

		mode = doSize;
		if (TEContinuousStyle(&mode, &theTextStyle, ((DocumentPeek) window)->docTE))
		{		
			switch (theTextStyle.tsSize)
			{
				case 9: item = iNine; break;
				case 10: item = iTen; break;
				case 12: item = iTwelve; break;
				case 14: item = iFourteen; break;
				case 18: item = iEighteen; break;
				case 24: item = iTwentyFour; break;
			};
			CheckItem(menu, item, true);
		};

		if (haveContinuousFont)
		{
			if (RealFont(theFont, 9))
				SetItemStyle(menu, iNine, outline);
			if (RealFont(theFont, 10))
				SetItemStyle(menu, iTen, outline);
			if (RealFont(theFont, 12))
				SetItemStyle(menu, iTwelve, outline);
			if (RealFont(theFont, 14))
				SetItemStyle(menu, iFourteen, outline);
			if (RealFont(theFont, 18))
				SetItemStyle(menu, iEighteen, outline);
			if (RealFont(theFont, 24))
				SetItemStyle(menu, iTwentyFour, outline);
		};
	}
	else
	{
		DisableMenu(menu);
	};
	
	menu = GetMenuHandle (mStyle);
	RemoveMenuCheckMarks(menu);
	if (frontIsDocWindow)
	{
		EnableMenu(menu);

		mode = doFace;
		if (TEContinuousStyle(&mode, &theTextStyle, ((DocumentPeek) window)->docTE))
		{
			CheckItem(menu, iPlain, theTextStyle.tsFace == normal);
			CheckItem(menu, iBold, (theTextStyle.tsFace & bold) == bold);
			CheckItem(menu, iItalic, (theTextStyle.tsFace & italic) == italic);
			CheckItem(menu, iUnderline, (theTextStyle.tsFace & underline) == underline);
			CheckItem(menu, iOutline, (theTextStyle.tsFace & outline) == outline);
			CheckItem(menu, iShadow, (theTextStyle.tsFace & shadow) == shadow);
		};		
	}
	else
	{
		DisableMenu(menu);
	};
	
	DrawMenuBar();
}


/*	This is called when an item is chosen from the menu bar (after calling
	MenuSelect or MenuKey). It does the right thing for each command. */

void DoMenuCommand(long menuResult)
{
	short		menuID, menuItem;
	short		itemHit, daRefNum;
	Str255		daName;
	OSErr		saveErr;
	TEHandle	te;
	WindowPtr	window;
	long		scrapLength;
	long		offset;
	Handle		aHandle;
	long		oldSize, newSize;
	long		total, contig;
	TextStyle	theTextStyle;
	Str255		theFontName;
	short		theFontID;
	short		theFontSize;
	DocumentPeek theDocument;
#if qInline
	TSMDocumentID tsmDoc;
#endif // qInline

	window = FrontWindow();
	menuID = HiWord(menuResult);
	menuItem = LoWord(menuResult);

#if qInline
	if (menuID == 0)
		// no real menu command, so we don't want to confirm inline input text
		return;
	
#endif // qInline
	if (IsDocumentWindow(window))
	{
		theDocument = (DocumentPeek) window;
		te = theDocument->docTE;
#if qInline

		// for any real menu command, we should first confirm inline input text if there is any
		tsmDoc = theDocument->docTSMDoc;
		if (tsmDoc != nil)
			(void) FixTSMDocument(tsmDoc);
#endif // qInline
	};
	
	switch ( menuID ) {
		case mApple:
			switch ( menuItem ) {
				case iAbout:		/* bring up alert for About */
					itemHit = Alert(rAboutAlert, nil);
					break;
				default:			/* all non-About items in this menu are DAs et al */
					/* type Str255 is an array in MPW 3 */
					GetMenuItemText(GetMenuHandle(mApple), menuItem, daName);
					daRefNum = OpenDeskAcc(daName);
					AdjustMenus();
					break;
			}
			break;
		case mFile:
			switch ( menuItem ) {
				case iNew:
					DoNew();
					break;
				case iClose:
					(void) DoCloseWindow(FrontWindow());			/* ignore the result */
					break;
				case iPageSetup:
					PrOpen();
					if (PrError() == noErr)
						(void) PrStlDialog(gPrinterRecord);
					PrClose();
					break;
				case iPrint:
					PrintText(te);
					break;
				case iQuit:
#if qAppleEvents
					PrepareToQuit();
#else // qAppleEvents
					Terminate();
#endif // qAppleEvents
					break;
			}
			break;
		case mEdit:					/* call SystemEdit for DA editing & MultiFinder */
			if ( !SystemEdit(menuItem-1) ) {
				switch ( menuItem ) {
					case iCut:
						if ( ZeroScrap() == noErr )
						{
							PurgeSpace(&total, &contig);
							if ((*te)->selEnd - (*te)->selStart + kTESlop > contig)
								AlertUser(eNoSpaceCut);
							else
							{
								TECut(te);
								theDocument->modified = true;
							};
						};
						break;
					case iCopy:
						if ( ZeroScrap() == noErr )
							TECopy(te);
						break;
					case iPaste:
						scrapLength = GetScrap(nil, 'TEXT', &offset);
						if ( scrapLength + ((*te)->teLength -
								((*te)->selEnd - (*te)->selStart)) > kMaxTELength )
							AlertUser(eExceedPaste);
						else
						{
							aHandle = (Handle) TEGetText(te);
							oldSize = GetHandleSize(aHandle);
							newSize = oldSize + scrapLength + kTESlop;
							SetHandleSize(aHandle, newSize);
							saveErr = MemError();
							SetHandleSize(aHandle, oldSize);
							if (saveErr != noErr)
								AlertUser(eNoSpacePaste);
							else
							{
								TEStylePaste(te);
								theDocument->modified = true;
							};
						};
						break;
					case iClear:
						TEDelete(te);
						theDocument->modified = true;
						break;
					case iSelectAll:
						TESetSelect(0, (*te)->teLength, te);
						break;
				};
			if (menuItem != iCopy)
				AdjustScrollbars(window, false);
			}
			break;
		case mFont:
			GetMenuItemText(GetMenuHandle(mFont), menuItem, theFontName);
			GetFNum(theFontName, &theFontID);
			theTextStyle.tsFont = theFontID;
			TESetStyle(doFont, &theTextStyle, true, te);
			if ((*te)->selEnd - (*te)->selStart > 0)
				theDocument->modified = true;
			AdjustScrollbars(window, false);
			break;
		case mFontSize:
			switch (menuItem)
			{
				case iNine:
					theFontSize = 9;
					break;
				case iTen:
					theFontSize = 10;
					break;
				case iTwelve:
					theFontSize = 12;
					break;
				case iFourteen:
					theFontSize = 14;
					break;
				case iEighteen:
					theFontSize = 18;
					break;
				case iTwentyFour:
					theFontSize = 24;
					break;
			};
			theTextStyle.tsSize = theFontSize;
			TESetStyle(doSize, &theTextStyle, true, te);
			if ((*te)->selEnd - (*te)->selStart > 0)
				theDocument->modified = true;
			AdjustScrollbars(window, false);
			break;
		case mStyle:
			switch (menuItem)
			{
				case iPlain:
					*((short *) &theTextStyle.tsFace) = 0; // see technote TE 16
					theTextStyle.tsFace = normal;
					break;
				case iBold:
					theTextStyle.tsFace = bold;
					break;
				case iItalic:
					theTextStyle.tsFace = italic;
					break;
				case iUnderline:
					theTextStyle.tsFace = underline;
					break;
				case iOutline:
					theTextStyle.tsFace = outline;
					break;
				case iShadow:
					theTextStyle.tsFace = shadow;
					break;
			};
			if (menuItem == iPlain)
				TESetStyle(doFace, &theTextStyle, true, te); // doToggle doesn't work for plain
			else
				TESetStyle(doFace + doToggle, &theTextStyle, true, te);
			if ((*te)->selEnd - (*te)->selStart > 0)
				theDocument->modified = true;
			AdjustScrollbars(window, false);
			break;
	};
	HiliteMenu(0);					/* unhighlight what MenuSelect (or MenuKey) hilited */
}


/* Create a new document and window. */

void DoNew(void)
{
	Boolean		good;
	Ptr			storage;
	WindowPtr	window;
	Rect		destRect, viewRect;
	DocumentPeek doc;
#if qInline
	OSType		supportedInterfaces[1];
#endif // qInline

	storage = NewPtr(sizeof(DocumentRecord));
	if ( storage != nil ) {
		doc = (DocumentPeek) storage;
		doc->modified = false;
#if qInline
		doc->docTSMTERecHandle = nil;
		doc->docTSMDoc = nil;
#endif // qInline
		window = GetNewWindow(rDocWindow, storage, (WindowPtr) -1);
		if ( window != nil ) {
			gNumDocuments += 1;			/* this will be decremented when we call DoCloseWindow */
			good = false;
			SetPort(window);
			
			// on a Roman system, the default text size is 0; we need a real size to make the Size menu work
			TextSize(GetDefFontSize());
			GetTERect(window, &viewRect);
			destRect = viewRect;
			destRect.right = destRect.left + kMaxDocWidth;
			doc->docTE = TEStyleNew(&destRect, &viewRect);
			good = doc->docTE != nil;	/* if TENew succeeded, we have a good document */
			if ( good ) {				/* 1.02 - good document? — proceed */
				TEAutoView(true, doc->docTE);
				doc->docClick = (*doc->docTE)->clickLoop;
#if powerc
				TESetClickLoop(gClickLoopUPP, doc->docTE);
#else
				(*doc->docTE)->clickLoop = (TEClickLoopUPP) AsmClickLoopProc;
#endif
			}
			
			if ( good ) {				/* good document? — get scrollbars */
				doc->docVScroll = GetNewControl(rVScroll, window);
				good = (doc->docVScroll != nil);
			}
			if ( good) {
				doc->docHScroll = GetNewControl(rHScroll, window);
				good = (doc->docHScroll != nil);
			}
#if qInline
			if (good && gHasTSMTE)
			{
				supportedInterfaces[0] = kTSMTEInterfaceType;
				if (NewTSMDocument(1, supportedInterfaces, &doc->docTSMDoc,
							(long) &doc->docTSMTERecHandle) == noErr)
				{
					TSMTERecPtr tsmteRecPtr = *(doc->docTSMTERecHandle);
					
					tsmteRecPtr->textH = doc->docTE;
					tsmteRecPtr->preUpdateProc = gTSMTEPreUpdateUPP;
					tsmteRecPtr->postUpdateProc = gTSMTEPostUpdateUPP;
					tsmteRecPtr->updateFlag = kTSMTEAutoScroll;
					tsmteRecPtr->refCon = (long) window;
				}
				else
					good = false;
			};
#endif // qInline

			if ( good ) {				/* good? — adjust & draw the controls, draw the window */
				/* false to AdjustScrollValues means musn’t redraw; technically, of course,
				the window is hidden so it wouldn’t matter whether we called ShowControl or not. */
				AdjustScrollValues(window, false);
				ShowWindow(window);
				AdjustMenus();
			} else {
				DoCloseWindow(window);	/* otherwise regret we ever created it... */
				AlertUser(eNoWindow);			/* and tell user */
			}
		} else
			DisposePtr(storage);			/* get rid of the storage if it is never used */
	}
} /*DoNew*/


/* Close a window. This handles desk accessory and application windows. */

/*	1.01 - At this point, if there was a document associated with a
	window, you could do any document saving processing if it is 'dirty'.
	DoCloseWindow would return true if the window actually closed, i.e.,
	the user didn’t cancel from a save dialog. This result is handy when
	the user quits an application, but then cancels the save of a document
	associated with a window. */

Boolean DoCloseWindow(WindowPtr window)
{
	DocumentPeek theDocument;

	if ( IsDAWindow(window) )
		CloseDeskAcc(((WindowPeek) window)->windowKind);
	else if ( IsDocumentWindow(window) ) {
		// ??? check modified flag whether document needs saving
		theDocument = (DocumentPeek) window;
#if qInline
		if (theDocument->docTSMDoc != nil)
		{
			(void) FixTSMDocument(theDocument->docTSMDoc);
			// DeleteTSMDocument might cause crash if we don't deactivate first, so...
			(void) DeactivateTSMDocument(theDocument->docTSMDoc);
			(void) DeleteTSMDocument(theDocument->docTSMDoc);
		};
#endif // qInline
		if (theDocument->docTE != nil)
			TEDispose(theDocument->docTE);
		/*	1.01 - We used to call DisposeWindow, but that was technically
			incorrect, even though we allocated storage for the window on
			the heap. We should instead call CloseWindow to have the structures
			taken care of and then dispose of the storage ourselves. */
		CloseWindow(window);
		DisposePtr((Ptr) window);
		gNumDocuments -= 1;
	}
	AdjustMenus();
	return true;
} /*DoCloseWindow*/


// PrintText prints the text in the edit record. It opens a printer port, calculates
// the number of lines per page (which may be different for each page depending on the
// text styles) and then calls TEUpdate for the page, scrolls a page and calls TEUpdate,
// etc.

static void PrintText(TEHandle theText)
{
	const short kMargin = 20; // page margins in pixels
	const Rect zeroRect = { 0, 0, 0, 0 };
	short totalLines;
	GrafPtr oldPort;
	Rect oldViewRect;
	Rect oldDestRect;
	Rect viewRect;
	Rect updateRect;
	Rect clipRect;
	short totalHeight;
	short currentLine;
	short scrollAmount;
	TPrStatus thePrinterStatus;
	Boolean printManagerIsOpen = false;
	Boolean userHasCancelled = false;
	short viewHeight;
	TPPrPort thePrinterPort;
	
	if (gPrinterRecord != nil)
	{
		PrOpen();
		if (PrJobDialog(gPrinterRecord))
		{
			GetPort(&oldPort);
			oldViewRect = (*theText)->viewRect;
			oldDestRect = (*theText)->destRect;
			thePrinterPort = PrOpenDoc(gPrinterRecord, nil, nil);
			printManagerIsOpen = (PrError() == noErr);
		};
	};
	
	if (printManagerIsOpen)
	{
		SetPort((GrafPtr) thePrinterPort);
		
		// re-wrap the text to fill the entire page minus margins
		viewRect = (*gPrinterRecord)->prInfo.rPage;
		InsetRect(&viewRect, kMargin, kMargin);
		(*theText)->inPort = (GrafPtr) thePrinterPort;
		(*theText)->destRect = viewRect;
		(*theText)->viewRect = viewRect;
		TECalText(theText);
		totalLines = (*theText)->nLines;
		totalHeight = TEGetHeight(totalLines, 0, theText);
		(*theText)->destRect.bottom = (*theText)->destRect.top + totalHeight;
		
		currentLine = 1;
		
		while ((!userHasCancelled) && (currentLine <= totalLines))
		{
			PrOpenPage(thePrinterPort, nil);
			scrollAmount = 0;
			clipRect = (*gPrinterRecord)->prInfo.rPage;
			ClipRect(&clipRect);
			
			viewHeight = (*theText)->viewRect.bottom - (*theText)->viewRect.top + 1;
			
			while (((scrollAmount + TEGetHeight(currentLine, currentLine, theText)) <= viewHeight)
						&& (currentLine <= totalLines))
			{
				scrollAmount += TEGetHeight(currentLine, currentLine, theText);
				currentLine++;
			};
			
			(*theText)->viewRect.bottom = scrollAmount + kMargin;
			TEDeactivate(theText); // avoid printing selections
			updateRect = (*theText)->viewRect;
			TEUpdate(&updateRect, theText);
			ClipRect(&zeroRect); // prevent TEScroll from redrawing the text
			TEScroll(0, -scrollAmount, theText); // scroll so we can print the next page
			(*theText)->viewRect.bottom = viewRect.bottom; // reset to full page;
			
			if (PrError() == iPrAbort)
				userHasCancelled = true;
			PrClosePage(thePrinterPort);
		};
		
		PrCloseDoc(thePrinterPort);

		if ((*gPrinterRecord)->prJob.bJDocLoop == bSpoolLoop && PrError() == noErr)
			PrPicFile(gPrinterRecord, nil, nil, nil, &thePrinterStatus);
		PrClose();
		
		SetPort(oldPort);
		(*theText)->inPort = oldPort;
		(*theText)->viewRect = oldViewRect;
		(*theText)->destRect = oldDestRect;
		TECalText(theText);
		updateRect = (*theText)->viewRect;
		TEUpdate(&updateRect, theText);
	};
}

#if qAppleEvents

// handle the Quit menu command or Apple event by closing all windows, and
// setting gQuitting if successful.

static void PrepareToQuit(void)
{
	WindowPtr aWindow;
	
	gQuitting = true;
	aWindow = FrontWindow();

	while (gQuitting && (aWindow != nil))
	{
		gQuitting = DoCloseWindow(aWindow);
		aWindow = FrontWindow();
	};
}

#if qInline

static void ExitApplication(void)
{
	if (gHasTextServices)
		(void) CloseTSMAwareApplication();

	// set global fontForce flag so other apps don't get confused
	(void) SetScriptManagerVariable(smFontForce, gSavedFontForce);

	ExitToShell();
}

#endif // qInline
#else // qAppleEvents

// handle the Quit menu command by closing all windows, and quitting if successful.

static void Terminate(void)
{
	WindowPtr aWindow;
	Boolean closed;
	
	closed = true;
	aWindow = FrontWindow();

	while (closed && (aWindow != nil))
	{
		closed = DoCloseWindow(aWindow);
		aWindow = FrontWindow();
	};

	if (closed)
		ExitToShell(); // exit if no cancellation
}

#endif // qAppleEvents

/* Return a rectangle that is inset from the portRect by the size of
	the scrollbars and a little extra margin. */

void GetTERect(WindowPtr window, Rect *teRect)
{
	*teRect = window->portRect;
	InsetRect(teRect, kTextMargin, kTextMargin);	/* adjust for margin */
	teRect->bottom = teRect->bottom - 15;		/* and for the scrollbars */
	teRect->right = teRect->right - 15;
} /*GetTERect*/


/* Update the TERec's view rect so that it is the greatest multiple of
	the lineHeight that still fits in the old viewRect. */

void AdjustViewRect(TEHandle docTE)
{
	TEPtr		te;
	
	te = *docTE;
	te->viewRect.bottom = (((te->viewRect.bottom - te->viewRect.top) / te->lineHeight)
							* te->lineHeight) + te->viewRect.top;
} /*AdjustViewRect*/


/* Scroll the TERec around to match up to the potentially updated scrollbar
	values. This is really useful when the window has been resized such that the
	scrollbars became inactive but the TERec was already scrolled. */

void AdjustTE(WindowPtr window)
{
	TEPtr		te;
	
	te = *((DocumentPeek)window)->docTE;
	TEScroll((te->viewRect.left - te->destRect.left) -
			GetControlValue(((DocumentPeek)window)->docHScroll),
			(te->viewRect.top - te->destRect.top) -
				GetControlValue(((DocumentPeek)window)->docVScroll),
			((DocumentPeek)window)->docTE);
} /*AdjustTE*/


/* Calculate the new control maximum value and current value, whether it is the horizontal or
	vertical scrollbar. The vertical max is calculated by comparing the number of lines to the
	vertical size of the viewRect. The horizontal max is calculated by comparing the maximum document
	width to the width of the viewRect. The current values are set by comparing the offset between
	the view and destination rects. If necessary and we canRedraw, have the control be re-drawn by
	calling ShowControl. */

// for styled text, we cannot rely on the line height being constant, so we
// have to use pixels instead of nLines

void AdjustHV(Boolean isVert, ControlHandle control, TEHandle docTE, Boolean canRedraw)
{
	short		value, max;
	short		oldValue, oldMax;
	
	oldValue = GetControlValue(control);
	oldMax = GetControlMaximum(control);
	if (isVert)
		max = TEGetHeight((*docTE)->nLines, 0, docTE) -
					((*docTE)->viewRect.bottom - (*docTE)->viewRect.top);
	else
		max = kMaxDocWidth - ((*docTE)->viewRect.right - (*docTE)->viewRect.left);
	if (max < 0)
		max = 0;
	SetControlMaximum(control, max);
	if (isVert)
		value = (*docTE)->viewRect.top - (*docTE)->destRect.top;
	else
		value = (*docTE)->viewRect.left - (*docTE)->destRect.left;
	
	if ( value < 0 )
		value = 0;
	else if ( value >  max ) value = max;
	
	SetControlValue(control, value);
	/* now redraw the control if it needs to be and can be */
	if ( canRedraw || (max != oldMax) || (value != oldValue) )
		ShowControl(control);
} /*AdjustHV*/


/* Simply call the common adjust routine for the vertical and horizontal scrollbars. */

void AdjustScrollValues(WindowPtr window, Boolean canRedraw)
{
	DocumentPeek doc;
	
	doc = (DocumentPeek)window;
	AdjustHV(true, doc->docVScroll, doc->docTE, canRedraw);
	AdjustHV(false, doc->docHScroll, doc->docTE, canRedraw);
} /*AdjustScrollValues*/


/*	Re-calculate the position and size of the viewRect and the scrollbars.
	kScrollTweek compensates for off-by-one requirements of the scrollbars
	to have borders coincide with the growbox. */

void AdjustScrollSizes(WindowPtr window)
{
	Rect		teRect;
	DocumentPeek doc;
	
	doc = (DocumentPeek) window;
	GetTERect(window, &teRect);							/* start with TERect */
	(*doc->docTE)->viewRect = teRect;
	MoveControl(doc->docVScroll, window->portRect.right - kScrollbarAdjust, -1);
	SizeControl(doc->docVScroll, kScrollbarWidth, (window->portRect.bottom - 
				window->portRect.top) - (kScrollbarAdjust - kScrollTweek));
	MoveControl(doc->docHScroll, -1, window->portRect.bottom - kScrollbarAdjust);
	SizeControl(doc->docHScroll, (window->portRect.right - 
				window->portRect.left) - (kScrollbarAdjust - kScrollTweek),
				kScrollbarWidth);
} /*AdjustScrollSizes*/


/* Turn off the controls by jamming a zero into their contrlVis fields (HideControl erases them
	and we don't want that). If the controls are to be resized as well, call the procedure to do that,
	then call the procedure to adjust the maximum and current values. Finally re-enable the controls
	by jamming a $FF in their contrlVis fields. */

void AdjustScrollbars(WindowPtr window, Boolean needsResize)
{
	DocumentPeek doc;
	
	doc = (DocumentPeek) window;
	/* First, turn visibility of scrollbars off so we won’t get unwanted redrawing */
	(*doc->docVScroll)->contrlVis = kControlInvisible;	/* turn them off */
	(*doc->docHScroll)->contrlVis = kControlInvisible;
	if ( needsResize )									/* move & size as needed */
		AdjustScrollSizes(window);
	AdjustScrollValues(window, needsResize);			/* fool with max and current value */
	/* Now, restore visibility in case we never had to ShowControl during adjustment */
	(*doc->docVScroll)->contrlVis = kControlVisible;	/* turn them on */
	(*doc->docHScroll)->contrlVis = kControlVisible;
} /* AdjustScrollbars */


// When the user selects text by dragging, TextEdit repeatedly calls a click loop routine which
// it gets from the TERecord's clikLoop field. TextEdit's default routine does some useful things,
// such as scrolling the text being selected, but it doesn't know about our scroll bars.
// Therefore, we replace the routine with one that calls both the old routine and an add-on routine
// which handles the scroll bars. Unfortunately, the way this works is very different for 68K and
// PowerPC. On 68K, we have to be aware that the original click loop routine has a register-based
// interface, so our replacement is easier to write in assembly. For PowerPC, we can let routine
// descriptors handle the argument conversions, and do everything in the C routine ClickLoopProc.

#if powerc
pascal Boolean ClickLoopProc(TEPtr pTE)
{
	CallTEClickLoopProc(GetOldClickLoop(), pTE);
	ClickLoopAddOn();
	return true;
}
#endif


// The ClickLoopAddOn routine handles the scroll bars during drag-scrolling.

pascal void ClickLoopAddOn(void)
{
	WindowPtr	window;
	RgnHandle	region;
	
	window = FrontWindow();
	region = NewRgn();
	GetClip(region);					/* save clip */
	ClipRect(&window->portRect);
	AdjustScrollValues(window, true);	/* pass true for canRedraw */
	SetClip(region);					/* restore clip */
	DisposeRgn(region);
}


// GetOldClickLoop returns the address of the default click loop routine that we put into the
// TERec when creating it.

pascal TEClickLoopUPP GetOldClickLoop(void)
{
	return ((DocumentPeek)FrontWindow())->docClick;
}


// Check whether a window is a document window created by the application.
// These windows have the windowKind userKind, so we can distinguish them from
// desk accessories, dialogs, and other windows.

Boolean IsDocumentWindow(WindowPtr window)
{
	return (window != nil) && (((WindowPeek) window)->windowKind == userKind);
}


// Check whether a window belongs to a desk accessory.
// These windows have negative windowKinds.

Boolean IsDAWindow(WindowPtr window)
{
	return (window != nil) && (((WindowPeek) window)->windowKind < 0);
}


/*	Display an alert that tells the user an error occurred, then exit the program.
	This routine is used as an ultimate bail-out for serious errors that prohibit
	the continuation of the application. Errors that do not require the termination
	of the application should be handled in a different manner. Error checking and
	reporting has a place even in the simplest application. The error number is used
	to index an 'STR#' resource so that a relevant message can be displayed. */

void AlertUser(short error)
{
	short		itemHit;
	Str255		message;

	SetCursor(&qd.arrow);
	/* type Str255 is an array in MPW 3 */
	GetIndString(message, rErrorStrings, error);
	ParamText(message, (ConstStr255Param) "", (ConstStr255Param) "", (ConstStr255Param) "");
	itemHit = Alert(rUserAlert, nil);
} /* AlertUser */

#if qAppleEvents

// Apple Event Support

static OSErr GotRequiredParameters(const AppleEvent *theAppleEvent)
{
	OSErr myErr;
	DescType returnedType;
	Size actualSize;
	
	myErr = AEGetAttributePtr(theAppleEvent, keyMissedKeywordAttr, typeWildCard, &returnedType,
				nil, 0, &actualSize);
	if (myErr == errAEDescNotFound)
		return noErr;
	else if (myErr == noErr)
		return errAEParamMissed;
	else
		return myErr;
}

pascal OSErr HandleOAppEvent(const AppleEvent *theEvent, const AppleEvent *reply, long refCon)
{
	#pragma unused(reply, refCon)
	
	OSErr theError;
	
	theError = GotRequiredParameters(theEvent);
	if (theError == noErr)
		DoNew();
	return theError;
}

pascal OSErr HandleDocEvent(const AppleEvent *theEvent, const AppleEvent *reply, long refCon)
{
	#pragma unused(theEvent, reply, refCon)
	
	OSErr theError;
	AEDescList docList;
	long itemsInList;
	long index;
	AEKeyword keyword;
	DescType returnedType;
	FSSpec theFileSpec;
	Size actualSize;
	
	
	theError = AEGetParamDesc(theEvent, keyDirectObject, typeAEList,  &docList);
	if (theError == noErr)
	{
		theError = GotRequiredParameters(theEvent);
		if (theError == noErr)
		{
			theError = AECountItems(&docList, &itemsInList);
			if (theError == noErr)
			{
				for (index = 1; index <= itemsInList; index++)
				{
					theError = AEGetNthPtr(&docList, index, typeFSS, &keyword, &returnedType,
								(Ptr) &theFileSpec, sizeof(theFileSpec), &actualSize);
					if (theError == noErr)
					{
						if (refCon == kAEOpenDocuments)
							// we don't open documents yet, but here's what it would look like:
							// theError = OpenDocument(theFileSpec);
							;
						else
							// we don't print disk documents either (we can't read them),
							// but here's what it would look like:
							// theError = PrintDocument(theFileSpec);
							;
					};
				};
			};
		};
		(void) AEDisposeDesc(&docList);
	};
	return theError;
}

pascal OSErr HandleQuitEvent(const AppleEvent *theEvent, const AppleEvent *reply, long refCon)
{
	#pragma unused(reply, refCon)
	
	OSErr theError;
	
	theError = GotRequiredParameters(theEvent);
	if (theError == noErr)
	{
		PrepareToQuit();
		if (!gQuitting)
			theError = userCanceledErr;
	};
	return theError;
}

static OSErr InstallRequiredAppleEvents(void)
{
	OSErr result;
	
	gHandleOAppUPP = NewAEEventHandlerProc(HandleOAppEvent);
	FailNilUPP((UniversalProcPtr) gHandleOAppUPP);
	gHandleDocUPP = NewAEEventHandlerProc(HandleDocEvent);
	FailNilUPP((UniversalProcPtr) gHandleDocUPP);
	gHandleQuitUPP = NewAEEventHandlerProc(HandleQuitEvent);
	FailNilUPP((UniversalProcPtr) gHandleQuitUPP);

	result = AEInstallEventHandler(kCoreEventClass, kAEOpenApplication,
				gHandleOAppUPP, 0, false);
	if (result == noErr)
		result = AEInstallEventHandler(kCoreEventClass, kAEOpenDocuments,
					gHandleDocUPP, kAEOpenDocuments, false);
	if (result == noErr)
		result = AEInstallEventHandler(kCoreEventClass, kAEPrintDocuments,
					gHandleDocUPP, kAEPrintDocuments, false);
	if (result == noErr)
		result = AEInstallEventHandler(kCoreEventClass, kAEQuitApplication,
					gHandleQuitUPP, 0, false);
	return result;
}

#if qInline

static pascal void MyTSMTEPreUpdateProc(TEHandle textH, long refCon)
{
	#pragma unused(refCon)

	long response;
	ScriptCode keyboardScript;
	short mode;
	TextStyle theStyle;
	
	if ((Gestalt(gestaltTSMTEVersion, &response) == noErr) && (response == gestaltTSMTE1))
	{
		keyboardScript = GetScriptManagerVariable(smKeyScript);
		mode = doFont;
		if (!(TEContinuousStyle(&mode, &theStyle, textH) &&
				FontToScript(theStyle.tsFont) == keyboardScript))
		{
			theStyle.tsFont = GetScriptVariable(keyboardScript, smScriptAppFond);
			TESetStyle(doFont, &theStyle, false, textH);
		};
	};
}

static pascal void MyTSMTEPostUpdateProc(TEHandle textH, long fixLen, long inputAreaStart,
			long inputAreaEnd, long pinStart, long pinEnd, long refCon)
{
	#pragma unused(textH, fixLen, inputAreaStart, inputAreaEnd, pinStart, pinEnd)
	
	AdjustScrollbars((WindowPtr) refCon, false);
	AdjustTE((WindowPtr) refCon);
}

#endif // qInline
#endif // qAppleEvents