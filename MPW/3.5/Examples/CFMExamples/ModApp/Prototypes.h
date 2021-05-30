/*
	File:		Prototypes.h

	Contains:	xxx put contents here xxx

	Written by:	Richard Clark

	Copyright:	© 1993 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 1/26/94	RC		Added DrawClippedGrowIcon
				  7/2/93	RC		d1 release

	To Do:
*/

#ifndef __MODAPP__
	#include "ModApp.h"
#endif

#ifndef __TYPES__
	#include <Types.h>
#endif

#ifndef __WINDOWS__
	#include <Windows.h>
#endif

#ifndef __WINDOWS__
	#include <Files.h>
#endif

/* Initialization.c */
void InitAll(void);
Boolean LibAvailable (Str255 libName);

/* AppleEventHandlers.c */
void InstallAppleEventHandlers(void);

/* Menus.c */
void UseMenuBar (Handle newMenuBar);
void AdjustMenus(void);
void Dispatch (int32 menuResult);
void BuildToolsMenu (void);

/* Windows.c */
void DrawClippedGrowIcon (WindowPtr wp);
void AlertUser (short messageCode, short errorNum);
void NewDisplayWindow (void);
void CloseAWindow (WindowPtr wp);
void DoUpdate (WindowPtr wp);
void DoActivate (EventRecord *theEvent);
void DoContentClick (WindowPtr wp, EventRecord *theEvent);
void DoGrowWindow(WindowPtr wp, EventRecord *theEvent);
void DoDragWindow(WindowPtr wp, EventRecord *theEvent);
void DoZoomWindow(WindowPtr wp, EventRecord *theEvent, int16 WindowPart);
void DoIdleWindow (WindowPtr wp);
void ClipToContentArea (WindowPtr wp);
void ResetClip (WindowPtr wp);

/* ToolLoader.c */
typedef void (*ToolInstallProcPtr)(FSSpec toolFileSpec);

void InitToolLoader(void);
void GetToolNames (ToolInstallProcPtr InstallNameCallback);
OSErr FindNamedTool (Str31 toolName, FSSpec *toolSpec);
OSErr LoadTool (FSSpec *toolSpec, WindowPtr wp);
OSErr UnloadTool (WindowPtr wp);

/* main.c */
// (Don't call us, we'll call you)