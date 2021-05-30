/*
	File:		MoreInterfaceLib.h

	Contains:	Interface to compatibility shim for routines not in InterfaceLib.

	Written by:	Quinn

	Copyright:	Copyright © 1999 by Apple Computer, Inc., all rights reserved.

				You may incorporate this Apple sample source code into your program(s) without
				restriction. This Apple sample source code has been provided "AS IS" and the
				responsibility for its operation is yours. You are not permitted to redistribute
				this Apple sample source code as "Apple sample source code" after having made
				changes. If you're going to re-distribute the source, we require that you make
				it clear in the source that the code was descended from Apple sample source
				code, but that you've made changes.

	Change History (most recent first):

        <10>    16/11/00    Quinn   Add a temporary fix to allow Carbon applications to call
                                    MoreBlockZero. Long term I need to come up with a better
                                    solution, but this is it for the moment.
         <9>      6/3/00    Quinn   Added modern Time Manager interfaces.
         <8>     16/9/99    Quinn   Add FSM FCB accessors.
         <7>     15/6/99    Quinn   Added MoreBlockZero.
         <6>     15/6/99    Quinn   Added Extended Disk Init Package routines.
         <5>     22/4/99    Quinn   Added PBRemoteAccess.
         <4>     20/4/99    Quinn   Added Gestalt Value routines.
         <3>     16/3/99    Quinn   Added MoreUTFindDrive and MoreAddDrive.
         <2>      1/3/99    Quinn   Added MoreFlushCodeCacheRange.  Also corrected a serious bug in
                                    MoreDriverInstallReserveMem, which was missing the #pragma
                                    parameter stuff.  Also some general tidy up.
         <1>     25/2/99    Quinn   First checked in.
*/

#pragma once

/////////////////////////////////////////////////////////////////

// MoreIsBetter Setup

#include "MoreSetup.h"

// Mac OS Interfaces

#include <MacTypes.h>
#include <Devices.h>
#include <MacMemory.h>
#include <FSM.h>

// MIB Interfaces

#include "RemoteAccessInterface.h"

#ifdef __cplusplus
extern "C" {
#endif

/////////////////////////////////////////////////////////////////

extern pascal SInt16 MoreLMGetUnitTableEntryCount(void)
	TWOWORDINLINE(0x3EB8, 0x01D2);

extern pascal void   MoreLMSetUnitTableEntryCount(SInt16 value)
	TWOWORDINLINE(0x31DF, 0x01D2);

/////////////////////////////////////////////////////////////////

	#if TARGET_CPU_68K && !TARGET_RT_MAC_CFM
	#pragma parameter __D0 MoreDriverInstallReserveMem(__A0, __D0)
	#endif

extern pascal OSErr  MoreDriverInstallReserveMem(DRVRHeaderPtr drvrPtr, DriverRefNum refNum)
	ONEWORDINLINE(0xA43D);

/////////////////////////////////////////////////////////////////

	#if TARGET_CPU_68K && !TARGET_RT_MAC_CFM
	#pragma parameter __D0 MoreFlushCodeCacheRange(__A0, __A1)
	#endif

extern pascal OSErr  MoreFlushCodeCacheRange(void *address, unsigned long count)
	TWOWORDINLINE(0x7009, 0xA098);

/////////////////////////////////////////////////////////////////

extern pascal OSErr MoreUTFindDrive(SInt16 driveNum, DrvQElPtr *driveQElementPtr)
	TWOWORDINLINE(0x700F, 0xA824);

extern pascal OSErr MoreUTLocateFCB(VCBPtr 				volCtrlBlockPtr,
								 unsigned long 			fileNum,
								 StringPtr 				namePtr,
								 short *				fileRefNum,
								 FCBRecPtr *			fileCtrlBlockPtr)
	TWOWORDINLINE(0x7002, 0xA824);

extern pascal OSErr MoreUTLocateNextFCB(VCBPtr 			volCtrlBlockPtr,
								 unsigned long 			fileNum,
								 StringPtr 				namePtr,
								 short *				fileRefNum,
								 FCBRecPtr *			fileCtrlBlockPtr)
	TWOWORDINLINE(0x7003, 0xA824);

extern pascal OSErr MoreUTIndexFCB(VCBPtr 				volCtrlBlockPtr,
								 short *				fileRefNum,
								 FCBRecPtr *			fileCtrlBlockPtr)
	TWOWORDINLINE(0x7004, 0xA824);

extern pascal OSErr MoreUTResolveFCB(short 				fileRefNum,
								 FCBRecPtr *			fileCtrlBlockPtr)
	TWOWORDINLINE(0x7005, 0xA824);

/////////////////////////////////////////////////////////////////

extern pascal void MoreAddDrive(DriverRefNum drvrRefNum, SInt16 drvNum, DrvQElPtr qEl);

/////////////////////////////////////////////////////////////////

extern pascal OSErr MoreNewGestaltValue(OSType selector, long newValue)
	THREEWORDINLINE(0x303C, 0x0401, 0xABF1);

extern pascal OSErr MoreReplaceGestaltValue(OSType selector, long replacementValue)
	THREEWORDINLINE(0x303C, 0x0402, 0xABF1);

extern pascal OSErr MoreSetGestaltValue(OSType selector, long newValue)		
	THREEWORDINLINE(0x303C, 0x0404, 0xABF1);

extern pascal OSErr MoreDeleteGestaltValue(OSType selector)
	THREEWORDINLINE(0x303C, 0x0203, 0xABF1);

/////////////////////////////////////////////////////////////////

extern pascal OSErr MorePBRemoteAccess(TPRemoteAccessParamBlock paramBlock, Boolean async)
	TWOWORDINLINE(0x7000,0xAA5B);

/////////////////////////////////////////////////////////////////

extern pascal OSErr MoreDIXFormat(	 short 					drvNum,
									 Boolean 				fmtFlag,
									 unsigned long 			fmtArg,
									 unsigned long *		actSize)
	THREEWORDINLINE(0x700C, 0x3F00, 0xA9E9);

extern pascal OSErr MoreDIXZero(	 short 					drvNum,
									 ConstStr255Param 		volName,
									 short 					fsid,
									 short 					mediaStatus,
									 short 					volTypeSelector,
									 unsigned long 			volSize,
									 void *					extendedInfoPtr)
	THREEWORDINLINE(0x700E, 0x3F00, 0xA9E9);

extern pascal OSErr MoreDIReformat(	 short 					drvNum,
									 short 					fsid,
									 ConstStr255Param 		volName,
									 ConstStr255Param 		msgText)
	THREEWORDINLINE(0x7010, 0x3F00, 0xA9E9);

/////////////////////////////////////////////////////////////////

#if TARGET_API_MAC_CARBON
	#define MoreBlockZero BlockZero
#else
	extern pascal void MoreBlockZero(void * destPtr, Size byteCount);
#endif

// "MacMemory.h" defines BlockZero as EXTERN_API_C, not EXTERN_API.
// We reverse that here so that we have a consistent interface for
// 68K clients.

/////////////////////////////////////////////////////////////////

	#if TARGET_CPU_68K && !TARGET_RT_MAC_CFM
	#pragma parameter __D0 MoreInstallTimeTask(__A0)
	#endif

extern pascal OSErr MoreInstallTimeTask(QElemPtr tmTaskPtr)
	ONEWORDINLINE(0xA058);

	#if TARGET_CPU_68K && !TARGET_RT_MAC_CFM
	#pragma parameter __D0 MoreInstallXTimeTask(__A0)
	#endif
	
extern pascal OSErr MoreInstallXTimeTask(QElemPtr tmTaskPtr)
	ONEWORDINLINE(0xA458);

	#if TARGET_CPU_68K && !TARGET_RT_MAC_CFM
	#pragma parameter __D0 MorePrimeTimeTask(__A0, __D0)
	#endif

extern pascal OSErr MorePrimeTimeTask(QElemPtr tmTaskPtr, long count)
	ONEWORDINLINE(0xA05A);

	#if TARGET_CPU_68K && !TARGET_RT_MAC_CFM
	#pragma parameter __D0 MoreRemoveTimeTask(__A0)
	#endif
	
extern pascal OSErr MoreRemoveTimeTask(QElemPtr tmTaskPtr)
	ONEWORDINLINE(0xA059);

#ifdef __cplusplus
}
#endif
