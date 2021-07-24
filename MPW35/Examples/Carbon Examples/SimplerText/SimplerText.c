/*
	File:		main.c
	
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
//#include <IBCarbonRuntime.h>
//#include <Debugging.h>
//#include <Script.h>

//-----------------------------------------------------------------------------------
//	AppEventHandler
//	Captures application-level events/commands.
//-----------------------------------------------------------------------------------

static const EventTypeSpec	sAppEvents[] =
{
	{ kEventClassCommand, kEventCommandProcess },
	{ kEventClassCommand, kEventCommandUpdateStatus },
	{ kEventClassMenu, kEventMenuEnableItems }
};

static pascal OSStatus
AppEventHandler(EventHandlerCallRef inCallRef, EventRef inEvent, void* inUserData)
{
#pragma unused (inCallRef, inUserData)

	OSStatus 		err = eventNotHandledErr;
	HICommand		command;
	UInt32			eventKind = GetEventKind(inEvent);
	MenuRef			menu;
	
	switch (GetEventClass(inEvent))
	{
		case kEventClassCommand:
			GetEventParameter(inEvent, kEventParamDirectObject, typeHICommand, NULL,
					sizeof(HICommand), NULL, &command);
			if (eventKind == kEventCommandProcess)
			{
				if (command.commandID == 'new ')
				{
					(new TTextWindow())->Show();
					err = noErr;
				}
			}
			else
			{
				if (command.commandID == 'clos')
				{
					DisableMenuCommand(NULL, 'clos');
					err = noErr;
				}
				else if ((command.attributes & kHICommandFromMenu) && (GetMenuID(command.menu.menuRef) == 131))
				{
					DisableMenuItem(command.menu.menuRef, 0);
				}
			}
			break;
		
		case kEventClassMenu:
			GetEventParameter(inEvent, kEventParamDirectObject, typeMenuRef, NULL,
					sizeof(MenuRef), NULL, &menu);

			if (GetMenuID(menu) == 131)
			{
				DisableMenuItem(menu, 0);
				return noErr;
			}
			break;
	}
	
	return err;
}

// ----------------------------------------------------------------------

int main(void)
{
    IBNibRef 			nibRef = NULL;
	OSErr				err;
	MenuRef				menu;
    TXNMacOSPreferredFontDescription    defaults;
	SInt16				fontID;
	HICommand			newCommand = { 0, 'new ' };
	TXNFontMenuObject	fontMenuObject;
	
	InitCursor();
	
    GetFNum("\pGeneva", &fontID);
	defaults.fontID = fontID;
    defaults.pointSize = kTXNDefaultFontSize;
    defaults.fontStyle = kTXNDefaultFontStyle;
    defaults.encoding = smRoman;
    TXNInitTextension(&defaults, 1, 0);

#if NIB_SUPPORT	
    err = CreateNibReference(CFSTR("main"), &nibRef);
	require_noerr(err, CantGetNibRef);
	
    err = SetMenuBarFromNib(nibRef, CFSTR("MainMenu"));
	require_noerr(err, CantSetMenuBar);
#else
	SetMenuBar(GetNewMBar(128));
#endif
    if ( (Ptr) CreateStandardWindowMenu != NULL )
    {
       	CreateStandardWindowMenu(0, &menu);
		SetMenuID(menu, 0);
		InsertMenu(menu, 0);
	}

#if NIB_SUPPORT	
	err = MakeWindows(nibRef);
	require_noerr(err, CantCreateWindow);
#endif

	TXNNewFontMenuObject(GetMenuHandle(131), 131, kStartHierMenuID, &fontMenuObject);

	TTextWindow::SetSharedFontMenu(fontMenuObject);

	InstallApplicationEventHandler(NewEventHandlerUPP(AppEventHandler),
									GetEventTypeCount(sAppEvents),
									sAppEvents,
									0,
									NULL);
									
	ProcessHICommand(&newCommand);

	RunApplicationEventLoop();

	TXNDisposeFontMenuObject(fontMenuObject);

	TXNTerminateTextension();
	
CantCreateWindow:
CantSetMenuBar:
CantGetNibRef:
	return err;
}
