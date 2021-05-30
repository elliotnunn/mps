/*
	File:		BasicWNE.c
	
	Contains:	Basic WaitNextEvent-based sample code shell, Carbon API

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

	Copyright © 1998-2001 Apple Computer, Inc., All Rights Reserved
*/

#ifdef __APPLE_CC__
#include <Carbon/Carbon.h>
#else
#include <Carbon.h>
#endif

void Initialize(void);
void MakeWindow(void);
void MakeMenu(void);
void EventLoop(void);
void DoEvent(EventRecord *event);
void DoMenuCommand(long menuResult);
void HandleWindowUpdate(WindowPtr window);
static pascal OSErr QuitAppleEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon);
void DoAboutBox(void);
void DoSomething(void);

#define 	kAboutBox		200		// About... alert
#define		rMenuBar		128		// Menu Bar
#define		mApple			128		// Apple menu
#define		iAbout			1
#define		mFile			129		// File menu 
#define		iQuitSeperator	10
#define		iQuit			11
#define		mEdit			130		// Edit menu 
#define		mTest			131		// Game menu 
#define		iThis			1
#define		iThat			2

Boolean	gQuitFlag;

int main(void)
{
	Initialize();
	MakeWindow();
	MakeMenu();
	EventLoop();
	return 0;
}
 
void Initialize()
{
	OSErr	err;
	
	InitCursor();

	err = AEInstallEventHandler( kCoreEventClass, kAEQuitApplication, NewAEEventHandlerUPP(QuitAppleEventHandler), 0, false );
	if (err != noErr)
		ExitToShell();
}

void MakeWindow()
{
	Rect		wRect;
	WindowPtr	myWindow;
	
	SetRect(&wRect,50,50,600,200);
	myWindow = NewCWindow(nil, &wRect, "\pHello", true, zoomNoGrow, (WindowPtr) -1, true, 0);
	
	if (myWindow != nil)
		SetPort(GetWindowPort(myWindow));
	else
		DebugStr("\p NewWindow failed");
}

void MakeMenu()	
{
	Handle		menuBar;
	MenuRef		menu;
	long		response;
	OSErr		err = noErr;
	
	menuBar = GetNewMBar(rMenuBar);	
	if (menuBar != nil)
	{
		SetMenuBar(menuBar);
		
		// see if we should modify quit in accordance with the Aqua HI guidelines
		err = Gestalt(gestaltMenuMgrAttr, &response);
		if ((err == noErr) && (response & gestaltMenuMgrAquaLayoutMask))
		{
			menu = GetMenuHandle(mFile);
			DeleteMenuItem(menu, iQuit);
			DeleteMenuItem(menu, iQuitSeperator);
		}
		DrawMenuBar();
	}
	else
		DebugStr("\p MakeMenu failed");
}

void EventLoop()
{
	Boolean		gotEvent;
	EventRecord	event;
	
	gQuitFlag = false;
	
	do
	{
		gotEvent = WaitNextEvent(everyEvent,&event,1,nil);
		if (gotEvent)
			DoEvent(&event);
	} while (!gQuitFlag);
		
	ExitToShell();
}

void DoEvent(EventRecord *event)
{
	short			part;
	Boolean			hit;
	char			key;
	Rect			tempRect;
	WindowPtr		myWindow;
	
	switch (event->what) 
	{
		case mouseDown:
			part = FindWindow(event->where, &myWindow);
			switch (part)
			{
				case inMenuBar:
					DoMenuCommand(MenuSelect(event->where));
					break;
				case inSysWindow:
					break;
				case inContent:
					if (myWindow != FrontWindow()) 
						SelectWindow(myWindow);
					break;
				case inDrag:				
					GetRegionBounds(GetGrayRgn(), &tempRect);
					DragWindow(myWindow, event->where, &tempRect);
					break;
				case inGrow:
					break;
				case inGoAway:
					DisposeWindow(myWindow);
					break;
				case inZoomIn:
				case inZoomOut:
					hit = TrackBox(myWindow, event->where, part);
					if (hit) 
					{
						SetPort(GetWindowPort(myWindow));
						EraseRect(GetWindowPortBounds(myWindow, &tempRect));
						ZoomWindow(myWindow, part, true);
						InvalWindowRect(myWindow, GetWindowPortBounds(myWindow, &tempRect));	
					}
					break;
			}
			break;
		case keyDown:
		case autoKey:
			key = event->message & charCodeMask;
			if (event->modifiers & cmdKey)
				if (event->what == keyDown)
					DoMenuCommand(MenuKey(key));
			break;
		case activateEvt:
			break;
		case updateEvt:
			HandleWindowUpdate((WindowPtr) event->message);
			break;
		case kHighLevelEvent:
			AEProcessAppleEvent( event );
			break;
		case diskEvt:
			break;
	}
}

void DoMenuCommand(long menuResult)
{
	short		menuID;				// resource ID of selected menu
	short		menuItem;			// item number of selected menu
	
	menuID = HiWord(menuResult);
	menuItem = LoWord(menuResult);
	
	switch (menuID) 
	{
		case mApple:
			switch (menuItem) 
			{
				case iAbout:
					DoAboutBox();
					break;
				default:
					break;
			}
			break;
		case mFile:
			switch (menuItem) 
			{
				case iQuit:
					ExitToShell();
					break;
			}
			break;
		case mEdit:
			break;
		case mTest:
			switch (menuItem) 
			{
				case iThis:
				case iThat:
					DoSomething();
					break;
			}
			break;
	}
	HiliteMenu(0);
}

void HandleWindowUpdate(WindowPtr window)
{
	Rect		tempRect;
	GrafPtr		curPort;
	
	GetPort(&curPort);
	SetPort(GetWindowPort(window));
	BeginUpdate(window);
	EraseRect(GetWindowPortBounds(window, &tempRect));
	DrawControls(window);
	DrawGrowIcon(window);
	EndUpdate(window);
	SetPort(curPort);
}

static pascal OSErr QuitAppleEventHandler( const AppleEvent *appleEvt, AppleEvent* reply, long refcon )
{
#pragma unused (appleEvt, reply, refcon)
	gQuitFlag =  true;
	return(noErr);
}

void DoAboutBox(void)
{
	Alert(kAboutBox, nil);  // simple alert dialog box
}

void DoSomething(void)
{
	SysBeep(2);
}
