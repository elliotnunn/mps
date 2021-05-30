/*
 	File:		Retrace.h
 
 	Contains:	Vertical Retrace Interfaces.
 
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

#ifndef __RETRACE__
#define __RETRACE__


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

typedef struct VBLTask VBLTask, *VBLTaskPtr;

/*
		VBLProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal void (*VBLProcPtr)(VBLTaskPtr vblTaskPtr);

		In:
		 => vblTaskPtr  	A0.L
*/

#if GENERATINGCFM
typedef UniversalProcPtr VBLUPP;
#else
typedef Register68kProcPtr VBLUPP;
#endif

struct VBLTask {
	QElemPtr						qLink;
	short							qType;
	VBLUPP							vblAddr;
	short							vblCount;
	short							vblPhase;
};
enum {
	uppVBLProcInfo = kRegisterBased
		 | REGISTER_ROUTINE_PARAMETER(1, kRegisterA0, SIZE_CODE(sizeof(VBLTaskPtr)))
};

#if GENERATINGCFM
#define NewVBLProc(userRoutine)		\
		(VBLUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppVBLProcInfo, GetCurrentArchitecture())
#else
#define NewVBLProc(userRoutine)		\
		((VBLUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallVBLProc(userRoutine, vblTaskPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppVBLProcInfo, (vblTaskPtr))
#else
/* (*VBLProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
#endif

extern pascal QHdrPtr GetVBLQHdr(void)
 THREEWORDINLINE(0x2EBC, 0x0000, 0x0160);

#if !GENERATINGCFM
#pragma parameter __D0 SlotVInstall(__A0, __D0)
#endif
extern pascal OSErr SlotVInstall(QElemPtr vblBlockPtr, short theSlot)
 ONEWORDINLINE(0xA06F);

#if !GENERATINGCFM
#pragma parameter __D0 SlotVRemove(__A0, __D0)
#endif
extern pascal OSErr SlotVRemove(QElemPtr vblBlockPtr, short theSlot)
 ONEWORDINLINE(0xA070);

#if !GENERATINGCFM
#pragma parameter __D0 AttachVBL(__D0)
#endif
extern pascal OSErr AttachVBL(short theSlot)
 ONEWORDINLINE(0xA071);

#if !GENERATINGCFM
#pragma parameter __D0 DoVBLTask(__D0)
#endif
extern pascal OSErr DoVBLTask(short theSlot)
 ONEWORDINLINE(0xA072);

#if !GENERATINGCFM
#pragma parameter __D0 VInstall(__A0)
#endif
extern pascal OSErr VInstall(QElemPtr vblTaskPtr)
 ONEWORDINLINE(0xA033);

#if !GENERATINGCFM
#pragma parameter __D0 VRemove(__A0)
#endif
extern pascal OSErr VRemove(QElemPtr vblTaskPtr)
 ONEWORDINLINE(0xA034);
/**/
/* Custom Glue for 68k.*/
/**/
#if !GENERATINGCFM
#ifndef CallVBLProc

#if !GENERATINGCFM
#pragma parameter VBLProcPtr68K(__A1, __A0)
#endif
extern pascal void VBLProcPtr68K(VBLUPP userRoutine, VBLTaskPtr userTask)
 FIVEWORDINLINE(0x48E7, 0xF030, 0x4E91, 0x4CDF, 0x0C0F);
/* Movem A2-A3/D0-D3,-(SP)*/
/* Jsr (A1)*/
/* Movem (SP)+,A2-A3/D0-D3*/
#define CallVBLProc(userRoutine, vblTaskPtr)  \
	VBLProcPtr68K(userRoutine, vblTaskPtr);
#endif
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

#endif /* __RETRACE__ */
