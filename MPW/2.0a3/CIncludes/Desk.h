/*
	Desk.h -- Desk Manager

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __DESK__
#define __DESK__
#ifndef __TYPES__
#include <Types.h>
#endif

#define accEvent 64
#define accRun 65
#define accCursor 66
#define accMenu 67
#define accUndo 68
#define accCut 70
#define accCopy 71
#define accPaste 72
#define accClear 73


pascal void CloseDeskAcc(refNum)
	short refNum;
	extern 0xA9B7;
pascal void SystemClick(theEvent,theWindow)
	struct EventRecord *theEvent;
	struct GrafPort *theWindow;
	extern 0xA9B3;
pascal Boolean SystemEdit(editCmd)
	short editCmd;
	extern 0xA9C2;
pascal void SystemTask()
	extern 0xA9B4;
pascal Boolean SystemEvent(theEvent)
	struct EventRecord *theEvent;
	extern 0xA9B2;
pascal void SystemMenu(menuResult)
	long menuResult;
	extern 0xA9B5;

#endif
