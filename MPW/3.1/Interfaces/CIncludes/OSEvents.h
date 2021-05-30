/************************************************************

Created: Thursday, September 7, 1989 at 5:11 PM
	OSEvents.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __OSEVENTS__
#define __OSEVENTS__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

struct EvQEl {
	QElemPtr qLink;
	short qType;
	short evtQWhat; 	/*this part is identical to the EventRecord as...*/
	long evtQMessage;	/*defined in ToolIntf*/
	long evtQWhen;
	Point evtQWhere;
	short evtQModifiers;
};

typedef struct EvQEl EvQEl;
typedef EvQEl *EvQElPtr;

#ifdef __cplusplus
extern "C" {
#endif
pascal OSErr PostEvent(short eventNum,long eventMsg);
pascal OSErr PPostEvent(short eventCode,long eventMsg,EvQElPtr *qEl);
pascal Boolean OSEventAvail(short mask,EventRecord *theEvent);
pascal Boolean GetOSEvent(short mask,EventRecord *theEvent);
pascal void FlushEvents(short whichMask,short stopMask)
	= {0x201F,0xA032};
pascal void SetEventMask(short theMask)
	= {0x31DF,0x0144};
pascal QHdrPtr GetEvQHdr(void); 
#ifdef __cplusplus
}
#endif

#endif
