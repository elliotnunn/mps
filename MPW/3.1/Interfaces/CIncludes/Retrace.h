/************************************************************

Created: Thursday, September 7, 1989 at 6:44 PM
	Retrace.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __RETRACE__
#define __RETRACE__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

typedef pascal void (*VBLProcPtr)(void);

typedef struct {
	QElemPtr qLink;
	short qType;
	VBLProcPtr vblAddr;
	short vblCount;
	short vblPhase;
}VBLTask;

#ifdef __cplusplus
extern "C" {
#endif
pascal QHdrPtr GetVBLQHdr(void);
pascal OSErr SlotVInstall(QElemPtr vblBlockPtr,short theSlot);
pascal OSErr SlotVRemove(QElemPtr vblBlockPtr,short theSlot);
pascal OSErr AttachVBL(short theSlot);
pascal OSErr DoVBLTask(short theSlot);
pascal OSErr VInstall(QElemPtr vblTaskPtr); 
pascal OSErr VRemove(QElemPtr vblTaskPtr);
#ifdef __cplusplus
}
#endif

#endif
