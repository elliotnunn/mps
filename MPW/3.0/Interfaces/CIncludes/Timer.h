/************************************************************

Created: Tuesday, October 4, 1988 at 9:58 PM
    Timer.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
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

#ifndef __cplusplus
typedef struct TMTask TMTask;
#endif

typedef TMTask *TMTaskPtr;

#ifdef __safe_link
extern "C" {
#endif
pascal void InsTime(QElemPtr tmTaskPtr); 
pascal void PrimeTime(QElemPtr tmTaskPtr,long count); 
pascal void RmvTime(QElemPtr tmTaskPtr); 
#ifdef __safe_link
}
#endif

#endif
