/************************************************************

Created: Thursday, September 7, 1989 at 4:00 PM
	Events.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __EVENTS__
#define __EVENTS__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#define nullEvent 0
#define mouseDown 1
#define mouseUp 2
#define keyDown 3
#define keyUp 4
#define autoKey 5
#define updateEvt 6
#define diskEvt 7
#define activateEvt 8
#define networkEvt 10
#define driverEvt 11
#define app1Evt 12
#define app2Evt 13
#define app3Evt 14
#define app4Evt 15
#define osEvt app4Evt
#define charCodeMask 0x000000FF
#define keyCodeMask 0x0000FF00
#define adbAddrMask 0x00FF0000
#define osEvtMessageMask 0xFF000000

/* OSEvent Messages */

#define mouseMovedMessage 0xFA
#define childDiedMessage 0xFD
#define suspendResumeMessage 0x01

/* event mask equates */

#define mDownMask 2
#define mUpMask 4
#define keyDownMask 8
#define keyUpMask 16
#define autoKeyMask 32
#define updateMask 64
#define diskMask 128
#define activMask 256
#define networkMask 1024
#define driverMask 2048
#define app1Mask 4096
#define app2Mask 8192
#define app3Mask 16384
#define app4Mask -32768
#define everyEvent -1

/* modifiers */

#define activeFlag 1	/*bit 0 of modifiers for activate event*/
#define btnState 128	/*Bit 7 of low byte is mouse button state*/
#define cmdKey 256		/*Bit 0*/
#define shiftKey 512	/*Bit 1*/
#define alphaLock 1024	/*Bit 2 */
#define optionKey 2048	/*Bit 3 of high byte*/
#define controlKey 4096

typedef long KeyMap[4];


struct EventRecord {
	short what;
	long message;
	long when;
	Point where;
	short modifiers;
};

typedef struct EventRecord EventRecord;
#ifdef __cplusplus
extern "C" {
#endif
pascal Boolean GetNextEvent(short eventMask,EventRecord *theEvent)
	= 0xA970;
pascal Boolean WaitNextEvent(short mask,EventRecord *event,unsigned long sleep,
	RgnHandle mouseRgn)
	= 0xA860;
pascal Boolean EventAvail(short eventMask,EventRecord *theEvent)
	= 0xA971;
pascal void GetMouse(Point *mouseLoc)
	= 0xA972;
pascal Boolean Button(void)
	= 0xA974;
pascal Boolean StillDown(void)
	= 0xA973;
pascal Boolean WaitMouseUp(void)
	= 0xA977;
pascal void GetKeys(KeyMap theKeys)
	= 0xA976;
pascal unsigned long TickCount(void)
	= 0xA975;
pascal unsigned long GetDblTime(void)
	= {0x2EB8,0x02F0};
pascal unsigned long GetCaretTime(void)
	= {0x2EB8,0x02F4};
#ifdef __cplusplus
}
#endif

#endif
