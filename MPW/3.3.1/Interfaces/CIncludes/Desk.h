/*
	File:		Desk.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __DESK__
#define __DESK__

#ifndef __TYPES__
#include <Types.h>
/*	#include <ConditionalMacros.h>								*/
/*	#include <MixedMode.h>										*/
/*		#include <Traps.h>										*/
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
/*	#include <QuickdrawText.h>									*/
/*		#include <IntlResources.h>								*/
#endif

#ifndef __EVENTS__
#include <Events.h>
/*	#include <OSUtils.h>										*/
#endif

enum  {
	accEvent					= 64,
	accRun						= 65,
	accCursor					= 66,
	accMenu						= 67,
	accUndo						= 68,
	accCut						= 70,
	accCopy						= 71,
	accPaste					= 72,
	accClear					= 73,
	goodbye						= -1							/*goodbye message*/
};

#ifdef __cplusplus
extern "C" {
#endif

extern pascal short OpenDeskAcc(ConstStr255Param deskAccName)
 ONEWORDINLINE(0xA9B6);
extern pascal void CloseDeskAcc(short refNum)
 ONEWORDINLINE(0xA9B7);
extern pascal void SystemClick(const EventRecord *theEvent, WindowPtr theWindow)
 ONEWORDINLINE(0xA9B3);
extern pascal Boolean SystemEdit(short editCmd)
 ONEWORDINLINE(0xA9C2);
extern pascal void SystemTask(void)
 ONEWORDINLINE(0xA9B4);
extern pascal Boolean SystemEvent(const EventRecord *theEvent)
 ONEWORDINLINE(0xA9B2);
extern pascal void SystemMenu(long menuResult)
 ONEWORDINLINE(0xA9B5);
extern short opendeskacc(char *deskAccName);
#ifdef __cplusplus
}
#endif

#endif

