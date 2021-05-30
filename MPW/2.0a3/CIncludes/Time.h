/*
	Time.h -- Time Manager
	
	version 2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985-1987
	All rights reserved.
	
	modifications:
		10feb87	KLH	incorrect extern trap #'s removed.
		13feb87	KLH	IM wrong! tmCount is long.
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
	long tmCount;
} TMTask, *TMTaskPtr;

pascal void InsTime(tmTaskPtr)
	TMTask *tmTaskPtr;
	extern;	
pascal void PrimeTime(tmTaskPtr,count)
	TMTask *tmTaskPtr;
	long count;
	extern;	
pascal void RmvTime(tmTaskPtr)
	TMTask *tmTaskPtr;
	extern;	
pascal OSErr DTInstall(dtTaskPtr)
	struct QElem *dtTaskPtr;
	extern;		
#endif
