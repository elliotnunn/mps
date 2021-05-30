/*
	Memory.h -- Memory Manager

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __MEMORY__
#define __MEMORY__
#ifndef __TYPES__
#include <Types.h>
#endif

#define maxSize 0x800000
typedef long Size;
typedef struct Zone {
	Ptr bkLim;
	Ptr purgePtr;
	Ptr hFstFree;
	long zcbFree;
	ProcPtr gzProc;
	short moreMast;
	short flags;
	short cntRel;
	short maxRel;
	short cntNRel;
	short maxNRel;
	short cntEmpty;
	short cntHandles;
	long minCBFree;
	ProcPtr purgeProc;
	Ptr sparePtr;
	Ptr allocPtr;
	short heapData;
} Zone,*THz;
Ptr GetApplLimit();
THz GetZone();
THz SystemZone();
THz ApplicZone();
Handle NewHandle();
THz HandleZone();
Handle RecoverHandle();
Ptr NewPtr();
THz PtrZone();
Handle GZSaveHnd();
Ptr TopMem();
pascal long MaxBlock()
	extern 0xA061;
pascal long StackSpace()
	extern 0xA065;
pascal Handle NewEmptyHandle()
	extern 0xA066;
#endif
