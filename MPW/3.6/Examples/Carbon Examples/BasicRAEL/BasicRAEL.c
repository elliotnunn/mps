/*
	File:		BasicRAEL.c
	
	Contains:	Basic RunApplicationEventLoop-based sample code shell, Carbon API

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

	Copyright © 1999-2001 Apple Computer, Inc., All Rights Reserved
*/

#ifdef __APPLE_CC__
#include <Carbon/Carbon.h>
#else
#include <Carbon.h>
#endif

void Initialize(void);
void MakeWindow(void);
void MakeMenu(void);
void InstallAppEvents(void);
static pascal OSStatus myWinEvtHndlr(EventHandlerCallRef myHandler, EventRef event, void* userData);
pascal OSStatus DoAppCommandProcess(EventHandlerCallRef nextHandler, EventRef theEvent, void* userData);
static void	HandleWindowUpdate(WindowRef window);
static pascal OSErr QuitAppleEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon);
void DoAboutBox(void);
void DoSomething(void);

EventHandlerUPP gAppCommandProcess;  	// Command-process event handler
EventHandlerUPP gWinEvtHandler;			// window event handler

#define kAboutBox		200				// About... alert
#define kCommandAbout  'abou'   		// Command ID of About command
#define mFile 129
#define	iQuitSeperator	10
#define iQuit 11

void main(void)
{	
	Initialize();
    MakeWindow();
    MakeMenu();
    InstallAppEvents();
    RunApplicationEventLoop();
    ExitToShell();
}

void Initialize()
{
	OSErr	err;

	InitCursor();
	
    err = AEInstallEventHandler(kCoreEventClass, kAEQuitApplication, NewAEEventHandlerUPP(QuitAppleEventHandler), 0, false);
	if (err != noErr)
		ExitToShell();
}

void MakeWindow()
{
	Rect		wRect;
	WindowRef	window;
	OSStatus	err;
    EventHandlerRef	ref;
	EventTypeSpec	list[] = { {kEventClassWindow, kEventWindowClose },
							   { kEventClassWindow, kEventWindowDrawContent },
                               //in Mac OS X Public Beta the following would be:
                               //{ kEventClassWindow, kEventWindowSizeChanged } }; 
							   { kEventClassWindow, kEventWindowBoundsChanged } };
	
	SetRect(&wRect,50,50,600,200);
	err = CreateNewWindow(kDocumentWindowClass, kWindowStandardDocumentAttributes | kWindowStandardHandlerAttribute,
                  			&wRect, &window);
	gWinEvtHandler = NewEventHandlerUPP(myWinEvtHndlr);
    InstallWindowEventHandler(window, gWinEvtHandler, 3, list, 0, &ref);
    ShowWindow(window);
}

void MakeMenu(void)
{
	Handle		menuBar;
	MenuRef 	menu;
	long 		response;
	OSStatus	err = noErr;

	menuBar = GetNewMBar(128);
	if (menuBar)
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

void InstallAppEvents(void)
{
	EventTypeSpec  eventType;

    gAppCommandProcess = NewEventHandlerUPP(DoAppCommandProcess);
	eventType.eventClass = kEventClassCommand;
	eventType.eventKind = kEventCommandProcess;
	InstallApplicationEventHandler(gAppCommandProcess, 1, &eventType, NULL, NULL);
}

static pascal OSStatus myWinEvtHndlr(EventHandlerCallRef myHandler, EventRef event, void* userData)
{
#pragma unused (myHandler, userData)
    WindowRef			window;
    Rect				bounds;
    OSStatus			result = eventNotHandledErr;

    GetEventParameter(event, kEventParamDirectObject, typeWindowRef, NULL, sizeof(window), NULL, &window);

    if (GetEventKind(event) == kEventWindowDrawContent)
    {
        HandleWindowUpdate(window);
        result = noErr;
    }
    //in Mac OS X Public Beta the following would be:
    //else if (GetEventKind(event) == kEventWindowSizeChanged)
    else if (GetEventKind(event) == kEventWindowBoundsChanged)
    {
        InvalWindowRect(window, GetWindowPortBounds(window, &bounds));
        result = noErr;
    }
    else if (GetEventKind(event) == kEventWindowClose)
    {
    	DisposeEventHandlerUPP(gWinEvtHandler);
        DisposeWindow(window);
        result = noErr;
    }
    return result;
}

// Handle command-process events at the application level
pascal OSStatus DoAppCommandProcess(EventHandlerCallRef nextHandler, EventRef theEvent, void* userData)
{
#pragma unused (nextHandler, userData)

	HICommand  aCommand;
	OSStatus   result;

	GetEventParameter(theEvent, kEventParamDirectObject, typeHICommand, NULL, sizeof(HICommand), NULL, &aCommand);
      
	switch (aCommand.commandID)
	{
		case 'abou':
			DoAboutBox();
			result = noErr; 
			break;
			
		case 'this':
		case 'that':
			DoSomething();
			result = noErr; 
			break;

		case kHICommandQuit:
			QuitApplicationEventLoop();
			result = noErr;
			break;
            
		default:
			result = eventNotHandledErr;
			break;
	}
      HiliteMenu(0);
      return result;
}

static void HandleWindowUpdate(WindowRef window)
{
    Rect bounds;
    
    SetPortWindowPort(window);
    EraseRect(GetWindowPortBounds(window, &bounds));
}

static pascal OSErr QuitAppleEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon)
{
#pragma unused (appleEvt, reply, refcon)
	QuitApplicationEventLoop();
#pragma noreturn (QuitAppleEventHandler)
}

void DoAboutBox(void)
{
	Alert(kAboutBox, nil);  // simple alert dialog box
}

void DoSomething(void)
{
	SysBeep(2);
}
