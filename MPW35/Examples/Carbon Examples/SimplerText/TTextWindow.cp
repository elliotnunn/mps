/*
	File:		TTextWindow.cp
	
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

	Copyright © 2001 Apple Computer, Inc., All Rights Reserved
*/


#include "TTextWindow.h"
//#include <Debugging.h>
//#include <AERegistry.h>

enum
{
	kEventClassKeyCompatibility		= 'kcom',
	kEventCompatibilityKeyDown		= 1,
	kEventCompatibilityKeyRepeat	= 2,
	kEventCompatibilityKeyUp		= 3
};

extern TXNFontMenuObject	gFontMenuObject;

static const Rect		sTextWindowBounds = { 40, 40, 500, 500 };

TXNFontMenuObject 	TTextWindow::fsFontMenuObject = NULL;
MenuRef 			TTextWindow::fsFontMenu = NULL;

TTextWindow::TTextWindow() : TWindow(	kDocumentWindowClass,
										kWindowStandardDocumentAttributes |
										kWindowInWindowMenuAttribute,
										sTextWindowBounds), fTimer(NULL)
{
	Rect 		temp = sTextWindowBounds;
	
	const EventTypeSpec	events[] =
		{
	//		{ kEventClassKeyCompatibility, kEventCompatibilityKeyDown },
	//		{ kEventClassKeyCompatibility, kEventCompatibilityKeyRepeat },
			{ kEventClassWindow, kEventWindowActivated },
			{ kEventClassWindow, kEventWindowDeactivated },
			{ kEventClassWindow, kEventWindowClickContentRgn },
			{ kEventClassWindow, kEventWindowBoundsChanged },
			{ kEventClassWindow, kEventWindowDrawContent },
			{ kEventClassCommand, kEventCommandProcess },
			{ kEventClassCommand, kEventCommandUpdateStatus },
			{ kEventClassMenu, kEventMenuEnableItems }
		};
		
	RegisterForEvents(GetEventTypeCount(events), events);

	SetTitle(CFSTR("Untitled"));
	
	verify_noerr(TXNNewObject(NULL, GetPlatformWindow(), NULL,
		kTXNWantVScrollBarMask,
		kTXNTextEditStyleFrameType, kTXNTextensionFile,
		kTXNSystemDefaultEncoding, &fObject, &fFrameID, this));
	
	RepositionWindow(GetPlatformWindow(), NULL, kWindowCascadeOnMainScreen);
}

TTextWindow::~TTextWindow()
{
	TXNDeleteObject(fObject);
}

OSStatus
TTextWindow::ProcessCommand(const HICommand& command)
{
	OSStatus		result = eventNotHandledErr;

// Textension needs to support new scrap manager!!

	switch (command.commandID)
	{
		case kHICommandUndo:
			TXNUndo(fObject);
			result = noErr;
			break;
		
		case kHICommandRedo:
			TXNRedo(fObject);
			result = noErr;
			break;
			
		case kHICommandSelectAll:
			TXNSelectAll(fObject);
			result = noErr;
			break;
		
		case kHICommandCut:
			TXNCut(fObject);
			result = noErr;
			break;

		case kHICommandCopy:
			TXNCopy(fObject);
			result = noErr;
			break;

		case kHICommandPaste:
			TXNPaste(fObject);
			result = noErr;
			break;

		case kHICommandClear:
			TXNClear(fObject);
			result = noErr;
			break;

		case 0:
			if (command.attributes & kHICommandFromMenu)
			{
				short menuID = GetMenuID(command.menu.menuRef);
				if ((command.menu.menuRef == fsFontMenu) || (menuID >= kStartHierMenuID))
				TXNDoFontMenuSelection(fObject, fsFontMenuObject, menuID, command.menu.menuItemIndex);
				result = noErr;
			}
			break;
	}
	
	return result;
}

OSStatus
TTextWindow::UpdateCommandStatus(const HICommand& command)
{
	OSStatus		result = eventNotHandledErr;
	TXNActionKey	actionKey;
	
	switch (command.commandID)
	{
		case kHICommandUndo:
			if (TXNCanUndo(fObject, &actionKey))
			{
				EnableMenuCommand(NULL, kHICommandUndo);
			}
			else
			{
				DisableMenuCommand(NULL, kHICommandUndo);
			}
			result = noErr;
			break;
		
		case kHICommandRedo:
			if (TXNCanRedo(fObject, &actionKey))
			{
				EnableMenuCommand(NULL, kHICommandRedo);
			}
			else
			{
				DisableMenuCommand(NULL, kHICommandRedo);
			}
			result = noErr;
			break;
		
		case kHICommandCut:
		case kHICommandCopy:
		case kHICommandClear:
			if (TXNIsSelectionEmpty(fObject))
				DisableMenuCommand(NULL, command.commandID);
			else
				EnableMenuCommand(NULL, command.commandID);
			result = noErr;
			break;
		
		case kHICommandPaste:
			if (TXNIsScrapPastable())
				EnableMenuCommand(NULL, command.commandID);
			else
				DisableMenuCommand(NULL, command.commandID);
			result = noErr;
			break;
		
		case kHICommandSelectAll:
			if (TXNDataSize(fObject) > 0)
				EnableMenuCommand(NULL, command.commandID);
			else
				DisableMenuCommand(NULL, command.commandID);
			result = noErr;
			break;
		
		case 'clos':
			EnableMenuCommand(NULL, command.commandID);
			result = noErr;
			break;
	}
	
	return result;
}

OSStatus
TTextWindow::HandleEvent(EventHandlerCallRef handler, EventRef inEvent)
{
#pragma unused (handler)

	OSStatus	result = eventNotHandledErr;
	UInt32		kind = GetEventKind(inEvent);
	
	switch (GetEventClass(inEvent))
	{	
		case kEventClassWindow:
			if (kind == kEventWindowActivated)
			{
				TXNActivate(fObject, fFrameID, true);
				TXNFocus(fObject, true);
				InstallEventLoopTimer(GetCurrentEventLoop(), 0, TicksToEventTime(GetCaretTime()),
						GetTimerUPP(), fObject, &fTimer);
			}
			else if (kind == kEventWindowDeactivated)
			{
				TXNFocus(fObject, false);
				RemoveEventLoopTimer(fTimer);
				fTimer = NULL;
			}
			else if (kind == kEventWindowDrawContent)
			{
				TXNDraw(fObject, NULL);
			}
			else if (kind == kEventWindowClickContentRgn)
			{
				EventRef		mouseEvent;
				EventRecord		er;
				
				GetEventParameter(inEvent, 'mous', typeEventRef, NULL,
						sizeof(EventRef), NULL, &mouseEvent);
				
				ConvertEventRefToEventRecord(mouseEvent, &er);
				TXNClick(fObject, &er);
			}
			else if (kind == kEventWindowBoundsChanged)
			{
				Rect		bounds;
				
				GetWindowBounds(GetPlatformWindow(), kWindowContentRgn, &bounds);
				TXNResizeFrame(fObject, bounds.right - bounds.left,
					bounds.bottom - bounds.top, fFrameID);
			}
			result = noErr;
			break;
		
		case kEventClassCommand:
			if (kind == kEventProcessCommand)
			{
				HICommand		cmd;
				
				GetEventParameter(inEvent, kEventParamDirectObject, typeHICommand, NULL,
						sizeof(HICommand), NULL, &cmd);
				result = ProcessCommand(cmd);
				HiliteMenu(0);
			}
			else if (kind == kEventCommandUpdateStatus)
			{
				HICommand		cmd;
				
				GetEventParameter(inEvent, kEventParamDirectObject, typeHICommand, NULL,
						sizeof(HICommand), NULL, &cmd);
				result = UpdateCommandStatus(cmd);
			}
			break;
		
		case kEventClassKeyCompatibility:
			{
				EventRecord		er;
				
				ConvertEventRefToEventRecord(inEvent, &er);
				TXNKeyDown(fObject, &er);
			}
			break;
		
		case kEventClassMenu:
			{
				MenuRef		menu;

				GetEventParameter(inEvent, kEventParamDirectObject, typeMenuRef, NULL,
						sizeof(MenuRef), NULL, &menu);

				if (menu == fsFontMenu)
				{
					EnableMenuItem(menu, 0);
					return noErr;
				}
			}
			break;
	}
	
	return result;
}

EventLoopTimerUPP
TTextWindow::GetTimerUPP()
{
	static EventLoopTimerUPP	sTimerUPP = NULL;
	
	if (sTimerUPP == NULL)
		sTimerUPP = NewEventLoopTimerUPP(CursorBlinker);
	
	return sTimerUPP;
}

pascal void
TTextWindow::CursorBlinker(EventLoopTimerRef inTimer, void* userData)
{
#pragma unused (inTimer)

	TXNIdle((TXNObject)userData);
}

void
TTextWindow::SetSharedFontMenu(TXNFontMenuObject inObject)
{
	fsFontMenuObject = inObject;
	TXNGetFontMenuHandle(inObject, &fsFontMenu);
}
