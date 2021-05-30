/*
	File:		ModApp.h

	Contains:	xxx put contents here xxx

	Written by:	Richard Clark

	Copyright:	© 1993 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				  7/2/93	RC		d1 release

	To Do:
*/


#ifndef __MODAPP__
#define __MODAPP__

#ifndef __WINDOWS__
	#include <Windows.h>
#endif

#ifndef __FILES__
	#include <Files.h>
#endif

#ifndef __TOOLAPI__
	#include "ToolAPI.h"
#endif

enum 	{
			// File types & creators
			kCreatorCode = 'moda',
			kToolType = 'modt'
		};


enum	{
			// Internal error codes
			kGenericError = 0,
			kNeedSystem7 = 1,
			kCFMNotPresent,
			kMixedModeNotPresent,
			kCodeNotFound
		};

enum	{
			// Menu ID numbers
			kAppleMenu = 1001,
			kFileMenu,
			kEditMenu,
			kModulesMenu,
			kDebugMenu
		};

enum	{
			// Apple menu commands
			cAbout = 1
		};

enum	{
			// File menu commands
			cNew = 1,
			cClose,
			/* --- */
			cQuit = 4
		};

#define	kDisplayWindow	1001
#define	kAboutDialog	1001
#define	kErrorDialog	1002
#define rToolMenuStrings 1001
#define rErrorStrings	1002

typedef	Byte	int8;	
typedef	short	int16;
typedef long	int32;


#ifdef powerc
	#pragma options align=mac68k
#endif
struct DrawingWindow {
	WindowRecord	theWindow;
	Handle			currMenuBar;		// Which menubar goes with this window?
	long			connectionID;
	Handle			toolResource;
	short			toolLocation;
	FSSpec			toolSpec;
	ToolInfoBlock	toolRoutines;
	long			toolRefCon;			// Tool-specific storage
};
#ifdef powerc
	#pragma options align=reset
#endif

typedef struct DrawingWindow DrawingWindow, *DrawingWindowPeek;

/* Global Variable Definitions */

#ifdef __Main__
	#define	global
#else
	#define	global	extern
#endif

global	Boolean		gDone;      			/* quit program flag	*/
global	int16		gMenuState;				/* In what state did we last leave our menu bar? */
global	WindowPtr	gCurrentWindow;			/* Which window are we redrawing? */
global	Handle		gCommonMenuBar;			/* The menubar for the app itself, with no tool menus */
global	Boolean		gHasMixedMode;			/* Do we have Mixed Mode? */
global	Boolean		gHasCFM;				/* Do we have the Code Fragment Manager? */

#define		isUserWindow(wp)	(wp && (((WindowPeek)wp)->windowKind == userKind))

#endif // __MODAPP__
