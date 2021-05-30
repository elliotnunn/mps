/************************************************************

Created: Thursday, September 7, 1989 at 8:09 PM
	Timer.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __TIMER__
#define __TIMER__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

typedef pascal void (*TimerProcPtr)(void);

struct TMTask {
	QElemPtr qLink;
	short qType;
	TimerProcPtr tmAddr;
	long tmCount;
};

typedef struct TMTask TMTask;
typedef TMTask *TMTaskPtr;

#ifdef __cplusplus
extern "C" {
#endif
pascal void InsTime(QElemPtr tmTaskPtr);
pascal void PrimeTime(QElemPtr tmTaskPtr,long count);
pascal void RmvTime(QElemPtr tmTaskPtr);
#ifdef __cplusplus
}
#endif

#endif
