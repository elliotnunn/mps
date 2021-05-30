/*
	Events.h -- Event Manager

	version	2.0a3
	
	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __EVENTS__
#define __EVENTS__
#ifndef __TYPES__
#include <Types.h>
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
#define charCodeMask 0x000000FF
#define keyCodeMask 0x0000FF00
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
#define app4Mask (-32768)
#define everyEvent (-1)
#define activeFlag 1
#define btnState 128
#define cmdKey 256
#define shiftKey 512
#define alphaLock 1024
#define optionKey 2048
typedef struct EventRecord {
	short what;
	long message;
	long when;
	Point where;
	short modifiers;
} EventRecord;
typedef long KeyMap[4];

pascal Boolean GetNextEvent(eventMask,theEvent)
	short eventMask;
	EventRecord *theEvent;
	extern 0xA970;
pascal Boolean EventAvail(eventMask,theEvent)
	short eventMask;
	EventRecord *theEvent;
	extern 0xA971;
pascal void GetMouse(mouseLoc)
	Point *mouseLoc;
	extern 0xA972;
pascal Boolean Button()
	extern 0xA974;
pascal Boolean StillDown()
	extern 0xA973;
pascal Boolean WaitMouseUp()
	extern 0xA977;
pascal void GetKeys(theKeys)
	KeyMap theKeys;
	extern 0xA976;
pascal long TickCount()
	extern 0xA975;
#endif
