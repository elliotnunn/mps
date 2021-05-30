/*
	OSEvents.h -- OS Event Manager

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __OSEVENTS__
#define __OSEVENTS__
#ifndef __TYPES__
#include <Types.h>
#endif

typedef struct EvQEl {
	struct QElem *qLink;
	short qType;
	short evtQWhat;
	long evtQMessage;
	long evtQWhen;
	Point evtQWhere;
	short evtQModifiers;
} EvQEl;
struct QHdr *GetEvQHdr();
#endif
