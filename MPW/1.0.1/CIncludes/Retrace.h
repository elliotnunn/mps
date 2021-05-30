/*
	Retrace.h -- Vertical Retrace Manager

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __RETRACE__
#define __RETRACE__
#ifndef __TYPES__
#include <Types.h>
#endif

typedef struct VBLTask {
	struct QElem *qLink;
	short qType;
	ProcPtr vblAddr;
	short vblCount;
	short vblPhase;
} VBLTask;
struct QHdr *GetVBLQHdr();
#endif
