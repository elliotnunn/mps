/*
	File:		Threads.h

	Copyright:	© 1984-1994 by Apple Computer, Inc., all rights reserved.

*/

#ifndef __THREADS__
#define __THREADS__

#include <Memory.h>

#define gestaltThreadMgrAttr 'thds'

enum  {
	gestaltThreadMgrPresent		= 0,
	gestaltSpecificMatchSupport	= 1,
	gestaltThreadsLibraryPresent = 2
};

typedef unsigned short ThreadState;

#define kReadyThreadState ((ThreadState) 0)

#define kStoppedThreadState ((ThreadState) 1)

#define kRunningThreadState ((ThreadState) 2)

typedef void *ThreadTaskRef;

typedef unsigned long ThreadStyle;

#define kCooperativeThread (1<<0)

#define kPreemptiveThread (1<<1)

typedef unsigned long ThreadID;

#define kNoThreadID ((ThreadID) 0)

#define kCurrentThreadID ((ThreadID) 1)

#define kApplicationThreadID ((ThreadID) 2)

typedef unsigned long ThreadOptions;

#define kNewSuspend (1<<0)

#define kUsePremadeThread (1<<1)

#define kCreateIfNeeded (1<<2)

#define kFPUNotNeeded (1<<3)

#define kExactMatchThread (1<<4)

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct SchedulerInfoRec {
	unsigned long				InfoRecSize;
	ThreadID					CurrentThreadID;
	ThreadID					SuggestedThreadID;
	ThreadID					InterruptedCoopThreadID;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct SchedulerInfoRec SchedulerInfoRec;

typedef SchedulerInfoRec *SchedulerInfoRecPtr;

typedef void *voidPtr;

typedef pascal voidPtr(*ThreadEntryProcPtr)(void *threadParam);

typedef pascal ThreadID (*ThreadSchedulerProcPtr)(SchedulerInfoRecPtr schedulerInfo);

typedef pascal void (*ThreadSwitchProcPtr)(ThreadID threadBeingSwitched, void *switchProcParam);

typedef pascal void (*ThreadTerminationProcPtr)(ThreadID threadTerminated, void *terminationProcParam);

typedef pascal void (*DebuggerNewThreadProcPtr)(ThreadID threadCreated);

typedef pascal void (*DebuggerDisposeThreadProcPtr)(ThreadID threadDeleted);

typedef pascal ThreadID (*DebuggerThreadSchedulerProcPtr)(SchedulerInfoRecPtr schedulerInfo);

enum  {
	threadTooManyReqsErr		= -617,
	threadNotFoundErr			= -618,
	threadProtocolErr			= -619
};

#ifdef __cplusplus
extern "C" {
#endif

extern pascal OSErr CreateThreadPool(ThreadStyle threadStyle, short numToCreate, Size stackSize)
 THREEWORDINLINE(0x303C, 0x0501, 0xABF2);
extern pascal OSErr GetFreeThreadCount(ThreadStyle threadStyle, short *freeCount)
 THREEWORDINLINE(0x303C, 0x0402, 0xABF2);
extern pascal OSErr GetSpecificFreeThreadCount(ThreadStyle threadStyle, Size stackSize, short *freeCount)
 THREEWORDINLINE(0x303C, 0x0615, 0xABF2);
extern pascal OSErr GetDefaultThreadStackSize(ThreadStyle threadStyle, Size *stackSize)
 THREEWORDINLINE(0x303C, 0x0413, 0xABF2);
extern pascal OSErr ThreadCurrentStackSpace(ThreadID thread, unsigned long *freeStack)
 THREEWORDINLINE(0x303C, 0x0414, 0xABF2);
extern pascal OSErr NewThread(ThreadStyle threadStyle, ThreadEntryProcPtr threadEntry, void *threadParam, Size stackSize, ThreadOptions options, void **threadResult, ThreadID *threadMade)
 THREEWORDINLINE(0x303C, 0x0E03, 0xABF2);
extern pascal OSErr DisposeThread(ThreadID threadToDump, void *threadResult, Boolean recycleThread)
 THREEWORDINLINE(0x303C, 0x0504, 0xABF2);
extern pascal OSErr YieldToThread(ThreadID suggestedThread)
 THREEWORDINLINE(0x303C, 0x0205, 0xABF2);
extern pascal OSErr YieldToAnyThread(void)
 FOURWORDINLINE(0x42A7, 0x303C, 0x0205, 0xABF2);
extern pascal OSErr GetCurrentThread(ThreadID *currentThreadID)
 THREEWORDINLINE(0x303C, 0x0206, 0xABF2);
extern pascal OSErr GetThreadState(ThreadID threadToGet, ThreadState *threadState)
 THREEWORDINLINE(0x303C, 0x0407, 0xABF2);
extern pascal OSErr SetThreadState(ThreadID threadToSet, ThreadState newState, ThreadID suggestedThread)
 THREEWORDINLINE(0x303C, 0x0508, 0xABF2);
extern pascal OSErr SetThreadStateEndCritical(ThreadID threadToSet, ThreadState newState, ThreadID suggestedThread)
 THREEWORDINLINE(0x303C, 0x0512, 0xABF2);
extern pascal OSErr SetThreadScheduler(ThreadSchedulerProcPtr threadScheduler)
 THREEWORDINLINE(0x303C, 0x0209, 0xABF2);
extern pascal OSErr SetThreadSwitcher(ThreadID thread, ThreadSwitchProcPtr threadSwitcher, void *switchProcParam, Boolean inOrOut)
 THREEWORDINLINE(0x303C, 0x070A, 0xABF2);
extern pascal OSErr SetThreadTerminator(ThreadID thread, ThreadTerminationProcPtr threadTerminator, void *terminationProcParam)
 THREEWORDINLINE(0x303C, 0x0611, 0xABF2);
extern pascal OSErr ThreadBeginCritical(void)
 THREEWORDINLINE(0x303C, 0x000B, 0xABF2);
extern pascal OSErr ThreadEndCritical(void)
 THREEWORDINLINE(0x303C, 0x000C, 0xABF2);
extern pascal OSErr SetDebuggerNotificationProcs(DebuggerNewThreadProcPtr notifyNewThread, DebuggerDisposeThreadProcPtr notifyDisposeThread, DebuggerThreadSchedulerProcPtr notifyThreadScheduler)
 THREEWORDINLINE(0x303C, 0x060D, 0xABF2);
extern pascal OSErr GetThreadCurrentTaskRef(ThreadTaskRef *threadTRef)
 THREEWORDINLINE(0x303C, 0x020E, 0xABF2);
extern pascal OSErr GetThreadStateGivenTaskRef(ThreadTaskRef threadTRef, ThreadID threadToGet, ThreadState *threadState)
 THREEWORDINLINE(0x303C, 0x060F, 0xABF2);
extern pascal OSErr SetThreadReadyGivenTaskRef(ThreadTaskRef threadTRef, ThreadID threadToSet)
 THREEWORDINLINE(0x303C, 0x0410, 0xABF2);
#ifdef __cplusplus
}
#endif

#endif

