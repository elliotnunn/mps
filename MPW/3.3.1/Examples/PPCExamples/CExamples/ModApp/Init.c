/*
	File:		Init.c

	Contains:	Initialization code for this application
				(also includes code to check the system configuration and
				look for externally loaded libraries)

	Written by:	Richard Clark

	Copyright:	© 1993 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				  12/3/93	RC		Added code to look for optional libraries
				  					and build pointers to their exported functions

				  11/28/93	RC		First release

	To Do:
*/


#ifndef __DIALOGS__
	#include <Dialogs.h>
#endif

#ifndef __FONTS__
	#include <Fonts.h>
#endif

#ifndef __WINDOWS__
	#include <Windows.h>
#endif

#ifndef __MENUS__
	#include <Menus.h>
#endif

#ifndef __TEXTEDIT__
	#include <TextEdit.h>
#endif

#ifndef __EVENTS__
	#include <Events.h>
#endif

#ifndef __OSEVENTS__
	#include <OSEvents.h>
#endif

#ifndef __GESTALTEQU__
	#include <GestaltEqu.h>
#endif

#ifndef __FRAGLOAD__
	#include <FragLoad.h>
#endif

#ifndef __MIXEDMODE__
	#include <MixedMode.h>
#endif

#include "ModApp.h"
#include "Prototypes.h"

// === Local prototypes & #defines
static short NumToolboxTraps ( void );
static TrapType GetTrapType (short theTrap);
static Boolean TrapAvailable (short theTrap);

#define TrapMask 0x0800

// === Local functions

static short NumToolboxTraps( void )
{
	if (NGetTrapAddress(_InitGraf, ToolTrap) ==
			NGetTrapAddress(0xAA6E, ToolTrap))
		return(0x0200);
	else
		return(0x0400);
}

static TrapType GetTrapType(short theTrap)
{

	if ((theTrap & TrapMask) > 0)
		return(ToolTrap);
	else
		return(OSTrap);

}

static Boolean TrapAvailable(short theTrap)
{

	TrapType	tType;

	tType = GetTrapType(theTrap);
	if (tType == ToolTrap)
	theTrap = theTrap & 0x07FF;
	if (theTrap >= NumToolboxTraps())
		theTrap = _Unimplemented;

	return (NGetTrapAddress(theTrap, tType) !=
			NGetTrapAddress(_Unimplemented, ToolTrap));
}

Boolean LibAvailable(Str255 libName)
// Check to see if a particular shared library is available
{
	ConnectionID	connID;
	Ptr				mainAddr;
	Str255			errName;
	OSErr			err;
	
	if (!gHasCFM) {
		return false;	// No Code Fragment Manager, hence no shared library
	} else {
		err = GetSharedLibrary(libName, kAnyArchType, kFindLib, &connID, &mainAddr, errName);
		return (err == noErr);
	}
}


static Boolean CheckConfiguration ()
{
	long		result;
	OSErr		err;
	Boolean		hasAppleEvents, hasFSpTraps, hasNewStdFile;
	
	// Verify that we can run on the current configuration
	// We need:
	//	Apple events
	//	FSSpec-based Standard File
	//	FSSpec-based file traps
	//
	// We would like to have:
	//	Mixed Mode
	//	Code Fragment Manager

	err = Gestalt(gestaltAppleEventsAttr, &result);
	hasAppleEvents = ((err == noErr) && (result & (1 << gestaltAppleEventsPresent)));
	
	err = Gestalt(gestaltFSAttr, &result);
	hasFSpTraps = ((err == noErr) && (result & (1 << gestaltHasFSSpecCalls)));
	
	err = Gestalt(gestaltStandardFileAttr, &result);
	hasNewStdFile = ((err == noErr) && (result & (1 << gestaltStandardFile58)));
		
	// *** Start checking for optional system features that we would like
	gHasMixedMode = TrapAvailable(_MixedModeMagic);
	gHasCFM = TrapAvailable (_CodeFragmentDispatch);

	return (hasAppleEvents & hasFSpTraps & hasNewStdFile);
}


// === Exported functions
void InitAll()
{	
	InitGraf(&qd.thePort);
	InitFonts();
	InitWindows();
	InitMenus();
	TEInit();
	InitDialogs(NULL);

	FlushEvents(everyEvent, 0);

	gCommonMenuBar = GetNewMBar(1001);
	SetMenuBar(gCommonMenuBar);	
	AddResMenu(GetMHandle(kAppleMenu), 'DRVR');
	InitToolLoader();
	BuildToolsMenu();	// Get a list of installed tools
	DrawMenuBar();

	if (!CheckConfiguration()) {
		AlertUser(kNeedSystem7, 0);
		ExitToShell();
	}

	gDone = false;	      				/* initialize flag to control Main Event Loop	*/
	gMenuState = 0;						/* We just loaded the menu bar */
	gCurrentWindow = NULL;				/* No windows in front */
	InstallAppleEventHandlers();
	InitCursor();		      			/* set the cursor to arrow instead of clock	*/

}
