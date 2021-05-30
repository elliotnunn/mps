/*
	File:		Menus.c

	Contains:	Common code for handling our Application's menus

	Written by:	Richard Clark

	Copyright:	© 1993, 1995 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				  11/29/93	RC		Updated AdjustMenus to hilight the Modules menu appropriately 
				  11/28/93	RC		Initial release

	To Do:
*/

#ifndef __MENUS__
	#include <Menus.h>
#endif

#ifndef __WINDOWS__
	#include <Windows.h>
#endif

#ifndef __DIALOGS__
	#include <Dialogs.h>
#endif

#ifndef __TEXTUTILS__
	#include <TextUtils.h>
#endif

#include <Menus.h>
#include <Devices.h>
#include <Events.h> 

#include "ModApp.h"
#include "Prototypes.h"

static void SetItemEnable (MenuHandle theMenu, int16 theItem, Boolean enabled);
static void EnableFileCommands (Boolean userWindow);
static void EnableModuleCommands (Boolean userWindow);
static void DoAppleCmds (int16 theItem);
static void DoFileCmds (int16 theItem);
static void DoToolCmds (int16 theItem);

static Handle gCurrentMenuBar = NULL;	// Handle to a tool's menu bar or NULL if the default menus are installed

void SetItemEnable (MenuHandle theMenu, int16 theItem, Boolean enabled)
{
	if (enabled)
		EnableItem(theMenu, theItem);
	else
		DisableItem(theMenu, theItem);
} /* SetItemEnable */


void EnableFileCommands (Boolean userWindow)
{
#pragma unused (userWindow)
	MenuHandle	fileMenu = GetMenuHandle(kFileMenu);
	WindowPtr	inFront = FrontWindow();

	SetItemEnable(fileMenu, cNew, !(inFront && (((WindowPeek)inFront)->windowKind == dialogKind)));
	SetItemEnable(fileMenu, cClose, (inFront && (((WindowPeek)inFront)->goAwayFlag)));
} /* EnableFileCommands */


void EnableModuleCommands (Boolean userWindow)
{
#pragma unused (userWindow)
	MenuHandle	moduleMenu = GetMenuHandle(kModulesMenu);
	WindowPtr	inFront = FrontWindow();

	SetItemEnable(moduleMenu, 0, userWindow);
	if (userWindow) {
		int16		item;
		Str255		currModuleName;
		
		GetWTitle(inFront, currModuleName);
		for (item = CountMItems(moduleMenu); item > 0; item--) {
			Str255		currItem;
			
			GetMenuItemText(moduleMenu, item, currItem);
			CheckItem(moduleMenu, item, EqualString(currItem, currModuleName, true, true));
		}
	}
} /* EnableModuleCommands */


static void ExternalMenuAdjust(DrawingWindowPeek aWindow)
// Find the tool associated with the frontmost window, and
// call its menu adjustment procedure.
{
	if ((gCurrentMenuBar != NULL) && (aWindow->toolRoutines.menuAdjustProc))
		CallToolMenuAdjustProc(aWindow->toolRoutines.menuAdjustProc, (WindowPtr)aWindow);
}


void UseMenuBar (Handle newMenuBar)
{
	// Install the specified menu bar, or the default menubar if "NULL" is specified
	if (newMenuBar == gCommonMenuBar)	// In case the user passed in the basic menu bar
		newMenuBar = NULL;
	if (newMenuBar != gCurrentMenuBar) {
		if (newMenuBar == NULL)
			SetMenuBar(gCommonMenuBar);
		else
			SetMenuBar(newMenuBar);
		gCurrentMenuBar = newMenuBar;
		DrawMenuBar();
	}
}	


void AdjustMenus()
{
	enum {
			kNoWindows = 1,
			kUsingDA,
			kUsingDocWindow,
			kUsingSpecialWindow
		};

	WindowPtr			inFront = FrontWindow();
	Boolean				isAUserWindow, isDeskAcc;
	int16				newMenuState;

	if (inFront == NULL) {
		// No window == turn nearly everything off!
		isAUserWindow = false;
		DisableItem(GetMenuHandle(kEditMenu), 0);
		EnableModuleCommands(false);
		EnableFileCommands(false);
		newMenuState = kNoWindows;
	} else {
		isAUserWindow = isUserWindow(inFront);
		if (isAUserWindow) {
			// We have a module window in front
			EnableFileCommands(true);
			EnableModuleCommands(true);
			DisableItem(GetMenuHandle(kEditMenu), 0);
			ExternalMenuAdjust((DrawingWindowPeek)inFront);
			newMenuState = kUsingDocWindow;
		} 
		else if ((isDeskAcc = ((WindowPeek)inFront)->windowKind < 0) == true) {
			// We have a desk accessory in front
			EnableFileCommands(false);
			EnableModuleCommands(false);
			EnableItem(GetMenuHandle(kEditMenu), 0);
			ExternalMenuAdjust((DrawingWindowPeek)inFront);
			newMenuState = kUsingDA;
		} else {
	   		// We have a window up front, but it's not a desk accessory or user window
			EnableFileCommands(false);
			EnableModuleCommands(false);
			ExternalMenuAdjust((DrawingWindowPeek)inFront);
			newMenuState = kUsingSpecialWindow;
		}
	}
	
	if (newMenuState != gMenuState) {
		DrawMenuBar();
		gMenuState = newMenuState;
	}
} /* AdjustMenus */



void DoAppleCmds (int16 theItem)
{
	Str255		name;			/* string for DA name	*/

	switch (theItem) {

		case cAbout: 
			Alert(kAboutDialog, NULL);
			break;
			
		default:
			GetMenuItemText(GetMenuHandle(kAppleMenu), theItem, (StringPtr)&name);
			OpenDeskAcc((StringPtr)&name);
	};
}

void DoFileCmds (int16 theItem)
{	
	switch (theItem) {

		case cNew: 
			NewDisplayWindow();
		break;
						
		case cClose: 
			CloseAWindow(FrontWindow());
		break;

		case cQuit: 
			gDone = true;
		break;
	}
} /* DoFileCmds */


void DoToolCmds (int16 theItem)
// Locate and load the named tool, unloading any tool that might already be in the window
{	
	Str31		toolName;
	FSSpec		toolSpec;
	OSErr		err;
	WindowPtr	inFront = FrontWindow();
	
	GetMenuItemText(GetMenuHandle(kModulesMenu), theItem, (StringPtr)&toolName);
	err = FindNamedTool (toolName, &toolSpec);
	if (err)
		AlertUser(0, err);
	else {
		DrawingWindowPeek	aWindow = (DrawingWindowPeek)inFront;
		
		if (aWindow) {
			// Unload any tool which might be atatched to the front window
			UnloadTool(inFront);
			// Load the new tool
			err = LoadTool (&toolSpec, inFront);
			if (err == noErr) {
				SetPort(inFront);
				InvalRect(&inFront->portRect);
			} 
		}
	}
} /* DoToolCmds */


static void ExternalMenuDispatch(DrawingWindowPeek aWindow, short theMenu, short theItem)
// Find the tool associated with the frontmost window, and
// call its menu adjustment procedure.
{
	if ((aWindow) && (gCurrentMenuBar != NULL) && (aWindow->toolRoutines.menuDispatchProc))
		CallToolMenuDispatchProc(aWindow->toolRoutines.menuDispatchProc, (WindowPtr)aWindow, theMenu, theItem);
}


void Dispatch (int32 menuResult)
{
	int16 	theMenu = (menuResult >> 16);					/* menu selected	*/
	int16 	theItem = (menuResult & 0x0000FFFF);       		/* item selected	*/

	switch (theMenu) {

		case kAppleMenu: 
			DoAppleCmds(theItem);
			break;
			
		case kFileMenu: 
			DoFileCmds(theItem);
			break;
			
		case kEditMenu: 
			SystemEdit(theItem - 1);
			break;
				
		case kModulesMenu:
			DoToolCmds(theItem);
			break;
			
		case kDebugMenu:
			Debugger();
			break;
		
		default:
			ExternalMenuDispatch((DrawingWindowPeek)FrontWindow(), theMenu, theItem);
	}
	HiliteMenu(0);	   		/* un-hilite selected menu */
}

// === Functions which are specific to the ModApp application
static MenuHandle toolMenuHandle;

static void InstallNameProc (FSSpec toolFileSpec)
{
	AppendMenu(toolMenuHandle, toolFileSpec.name);
}


void BuildToolsMenu()
{
	toolMenuHandle = GetMenuHandle(kModulesMenu);
	if (toolMenuHandle) {
		short item;
		
		// Remove all entries from the tools menu
		for (item = CountMItems(toolMenuHandle); item > 0; item--)
			DeleteMenuItem(toolMenuHandle, item);
			
		// Add a list of tool names
		GetToolNames(InstallNameProc);
		
		// No names? Tell the user that this was a failure
		if (CountMItems(toolMenuHandle) == 0) {
			Str255	noToolsString;
			
			GetIndString(noToolsString, rToolMenuStrings, 1);
			AppendMenu(toolMenuHandle, noToolsString);
			DisableItem(toolMenuHandle, 0);
			DisableItem(toolMenuHandle, 1);
		}
	}
}


