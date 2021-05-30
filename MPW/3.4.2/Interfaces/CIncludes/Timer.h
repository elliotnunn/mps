/*
 	File:		Timer.h
 
 	Contains:	Time Manager interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __TIMER__
#define __TIMER__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif
/*	#include <MixedMode.h>										*/
/*	#include <Memory.h>											*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
/* high bit of qType is set if task is active */
	kTMTaskActive				= (1L << 15)
};

typedef struct TMTask TMTask, *TMTaskPtr;

/*
		TimerProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal void (*TimerProcPtr)(TMTaskPtr tmTaskPtr);

		In:
		 => tmTaskPtr   	A1.L
*/

#if GENERATINGCFM
typedef UniversalProcPtr TimerUPP;
#else
typedef Register68kProcPtr TimerUPP;
#endif

struct TMTask {
	QElemPtr						qLink;
	short							qType;
	TimerUPP						tmAddr;
	long							tmCount;
	long							tmWakeUp;
	long							tmReserved;
};

#if !GENERATINGCFM
#pragma parameter InsTime(__A0)
#endif
extern pascal void InsTime(QElemPtr tmTaskPtr)
 ONEWORDINLINE(0xA058);

#if !GENERATINGCFM
#pragma parameter InsXTime(__A0)
#endif
extern pascal void InsXTime(QElemPtr tmTaskPtr)
 ONEWORDINLINE(0xA458);

#if !GENERATINGCFM
#pragma parameter PrimeTime(__A0, __D0)
#endif
extern pascal void PrimeTime(QElemPtr tmTaskPtr, long count)
 ONEWORDINLINE(0xA05A);

#if !GENERATINGCFM
#pragma parameter RmvTime(__A0)
#endif
extern pascal void RmvTime(QElemPtr tmTaskPtr)
 ONEWORDINLINE(0xA059);
extern pascal void Microseconds(UnsignedWide *microTickCount)
 FOURWORDINLINE(0xA193, 0x225F, 0x22C8, 0x2280);
enum {
	uppTimerProcInfo = kRegisterBased
		 | REGISTER_ROUTINE_PARAMETER(1, kRegisterA1, SIZE_CODE(sizeof(TMTaskPtr)))
};

#if GENERATINGCFM
#define NewTimerProc(userRoutine)		\
		(TimerUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTimerProcInfo, GetCurrentArchitecture())
#else
#define NewTimerProc(userRoutine)		\
		((TimerUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallTimerProc(userRoutine, tmTaskPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTimerProcInfo, (tmTaskPtr))
#else
/* (*TimerProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
#endif


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __TIMER__ */
