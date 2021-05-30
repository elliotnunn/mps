/************************************************************

Created: Tuesday, October 4, 1988 at 5:30 PM
    Desk.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988 
    All rights reserved

************************************************************/


#ifndef __DESK__
#define __DESK__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
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
#define goodbye -1  /*goodbye message*/

#ifdef __safe_link
extern "C" {
#endif
pascal short OpenDeskAcc(const Str255 theAcc)
    = 0xA9B6; 
pascal void CloseDeskAcc(short refNum)
    = 0xA9B7; 
pascal void SystemClick(const EventRecord *theEvent,WindowPtr theWindow)
    = 0xA9B3; 
pascal Boolean SystemEdit(short editCmd)
    = 0xA9C2; 
pascal void SystemTask(void)
    = 0xA9B4; 
pascal Boolean SystemEvent(const EventRecord *theEvent)
    = 0xA9B2; 
pascal void SystemMenu(long menuResult)
    = 0xA9B5; 
short opendeskacc(char *theAcc); 
#ifdef __safe_link
}
#endif

#endif
