/*
	File:		Retrace.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __RETRACE__
#define __RETRACE__

#ifndef __TYPES__
#include <Types.h>
/*	#include <ConditionalMacros.h>								*/
/*	#include <MixedMode.h>										*/
/*		#include <Traps.h>										*/
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

typedef struct VBLTask VBLTask, *VBLTaskPtr;


/*
	VBLProcs cannot be written in or called from a high-level language without 
	the help of mixed mode or assembly glue because they use the following 
	parameter-passing convention:

	typedef pascal void (*VBLProcPtr)(VBLTaskPtr vblTaskPtr);

		In:
			=> 	vblTaskPtr				A0.L
		Out:
			none
*/

enum  {
	uppVBLProcInfo				= kRegisterBased|REGISTER_ROUTINE_PARAMETER(1,kRegisterA0,kFourByteCode)
};

#if USESROUTINEDESCRIPTORS
typedef pascal void (*VBLProcPtr)(VBLTaskPtr vblTaskPtr);

typedef UniversalProcPtr VBLUPP;

#define CallVBLProc(userRoutine, vblTaskPtr)  \
	CallUniversalProc((UniversalProcPtr)(userRoutine), uppVBLProcInfo, (vblTaskPtr))

#define NewVBLProc(userRoutine)  \
	(VBLUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppVBLProcInfo, GetCurrentISA())

#else
typedef ProcPtr VBLUPP;

#define NewVBLProc(userRoutine)  \
	(VBLUPP)(userRoutine)

#endif

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct VBLTask {
	QElemPtr					qLink;
	short						qType;
	VBLUPP						vblAddr;
	short						vblCount;
	short						vblPhase;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if USESCODEFRAGMENTS
extern pascal QHdrPtr GetVBLQHdr(void);
#else
#define GetVBLQHdr() ((QHdrPtr) 0x0160)

#endif


#if USES68KINLINES
#pragma parameter __D0 SlotVInstall(__A0, __D0)
#endif
extern pascal OSErr SlotVInstall(QElemPtr vblBlockPtr, short theSlot)
 ONEWORDINLINE(0xA06F);

#if USES68KINLINES
#pragma parameter __D0 SlotVRemove(__A0, __D0)
#endif
extern pascal OSErr SlotVRemove(QElemPtr vblBlockPtr, short theSlot)
 ONEWORDINLINE(0xA070);

#if USES68KINLINES
#pragma parameter __D0 AttachVBL(__D0)
#endif
extern pascal OSErr AttachVBL(short theSlot)
 ONEWORDINLINE(0xA071);

#if USES68KINLINES
#pragma parameter __D0 DoVBLTask(__D0)
#endif
extern pascal OSErr DoVBLTask(short theSlot)
 ONEWORDINLINE(0xA072);

#if USES68KINLINES
#pragma parameter __D0 VInstall(__A0)
#endif
extern pascal OSErr VInstall(QElemPtr vblTaskPtr)
 ONEWORDINLINE(0xA033);

#if USES68KINLINES
#pragma parameter __D0 VRemove(__A0)
#endif
extern pascal OSErr VRemove(QElemPtr vblTaskPtr)
 ONEWORDINLINE(0xA034);
#ifdef __cplusplus
}
#endif

#endif
