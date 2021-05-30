/*
 	File:		ShutDown.h
 
 	Contains:	Shutdown Manager Interfaces.
 
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

#ifndef __SHUTDOWN__
#define __SHUTDOWN__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

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
	sdOnPowerOff				= 1,							/*call procedure before power off.*/
	sdOnRestart					= 2,							/*call procedure before restart.*/
	sdOnUnmount					= 4,							/*call procedure before unmounting.*/
	sdOnDrivers					= 8,							/*call procedure before closing drivers.*/
	sdRestartOrPower			= 3								/*call before either power off or restart.*/
};

/*
		ShutDwnProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal void (*ShutDwnProcPtr)(short shutDownStage);

		In:
		 => shutDownStage	D0.W
*/

#if GENERATINGCFM
typedef UniversalProcPtr ShutDwnUPP;
#else
typedef Register68kProcPtr ShutDwnUPP;
#endif

enum {
	uppShutDwnProcInfo = kRegisterBased
		 | REGISTER_ROUTINE_PARAMETER(1, kRegisterD0, SIZE_CODE(sizeof(short)))
};

#if GENERATINGCFM
#define NewShutDwnProc(userRoutine)		\
		(ShutDwnUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppShutDwnProcInfo, GetCurrentArchitecture())
#else
#define NewShutDwnProc(userRoutine)		\
		((ShutDwnUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallShutDwnProc(userRoutine, shutDownStage)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppShutDwnProcInfo, (shutDownStage))
#else
/* (*ShutDwnProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
#endif

extern pascal void ShutDwnPower(void)
 THREEWORDINLINE(0x3F3C, 0x0001, 0xA895);
extern pascal void ShutDwnStart(void)
 THREEWORDINLINE(0x3F3C, 0x0002, 0xA895);
extern pascal void ShutDwnInstall(ShutDwnUPP shutDownProc, short flags)
 THREEWORDINLINE(0x3F3C, 0x0003, 0xA895);
extern pascal void ShutDwnRemove(ShutDwnUPP shutDownProc)
 THREEWORDINLINE(0x3F3C, 0x0004, 0xA895);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SHUTDOWN__ */
