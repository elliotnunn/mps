/*
	File:		MainApp.c

	Contains:	The sample application for the "calling 68K code from PowerPC" demo

	Written by:	Richard Clark

	Copyright:	© 1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 2/15/94	RC		Released

	To Do:
*/

#include <Quickdraw.h>
#include <Fonts.h>
#include <Menus.h>
#include <TextEdit.h>
#include <Windows.h>
#include <Dialogs.h>
#include <OSUtils.h>
#include <Resources.h>
#include <SegLoad.h>
#include <Events.h>

#include "WrapperTable.h"
#include <MixedMode.h>

JumpTable	gCodePointers = {NULL};	// Table which contains addresses of our 68K routines

QDGlobals	qd;

main()
{
	Handle		ourLib;
	Rect		bounds = {40, 10, 140, 210};
	WindowPtr	wp;
	long		result;
	
	// Initialize the ROM
	InitGraf(&qd.thePort);
	InitFonts();
	InitWindows();
	InitMenus();
	TEInit();
	InitDialogs(nil);
	InitCursor();

	wp = NewWindow(NULL, &bounds, "\pDemo", true, noGrowDocProc, (WindowPtr)-1, false, 0);
	if (wp) {
		SetPort(wp);
		MoveTo(2, 12);
	} else {
		SysBeep(5);
		ExitToShell();
	}
	
	// Load our library resource
	ourLib = Get1IndResource('WRAP', 1);
	if (ourLib) {
		MoveHHi(ourLib);
		HLock(ourLib);	// Lock it -- and NEVER unlock it
		// Call the entry point, no parameters
		CallUniversalProc((UniversalProcPtr)*ourLib, kPascalStackBased /* no result, no params */);
		// Did we get the information?
		if (gCodePointers.routine1) {
			DrawString("\pAddress loaded");
			// Just for fun -- call the routine
			// N.B. Result sizes can be specified using the constants kOneByteCode through kFourByteCode, or using the
			// SIZE_CODE(some item) macro
		
			result = CallUniversalProc(gCodePointers.routine1,
									   kPascalStackBased | RESULT_SIZE(SIZE_CODE(sizeof(short))) | STACK_ROUTINE_PARAMETER(1, kFourByteCode),
									   5L /* Here's the actual parameter */);

		} else
			DrawString("\pAddress not loaded");
	} else
		DrawString("\pGet1IndResource failed");
	
	while (Button());
	while (!Button());
	
	return 0;
}

