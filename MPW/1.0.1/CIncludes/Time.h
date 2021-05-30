/*
	Time.h -- Time Manager

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __TIME__
#define __TIME__
#ifndef __TYPES__
#include <Types.h>
#endif

typedef struct TMTask {
	struct QElem *qLink;
	short qType;
	ProcPtr tmAddr;
	short tmCount;
} TMTask;
pascal void InsTime(tmTaskPtr)
	TMTask *tmTaskPtr;
	extern 0xA058;
pascal void PrimeTime(tmTaskPtr,count)
	TMTask *tmTaskPtr;
	long count;
	extern 0xA059;
pascal void RmvTime(tmTaskPtr)
	TMTask *tmTaskPtr;
	extern 0xA05A;
#endif
