/*
 	File:		DriverServices.h
 
 	Contains:	Driver Services Interfaces.
 
 	Version:	Technology:	PowerSurge 1.0.2.
 				Package:	Universal Interfaces 2.1.2 on ETO #20
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __DRIVERSERVICES__
#define __DRIVERSERVICES__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __KERNEL__
#include <Kernel.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <MachineExceptions.h>								*/

#ifndef __MENUS__
#include <Menus.h>
#endif
/*	#include <Memory.h>											*/
/*		#include <MixedMode.h>									*/
/*	#include <Quickdraw.h>										*/
/*		#include <QuickdrawText.h>								*/

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __DEVICES__
#include <Devices.h>
#endif
/*	#include <OSUtils.h>										*/
/*	#include <Files.h>											*/
/*	#include <Events.h>											*/
/*	#include <Dialogs.h>										*/
/*		#include <Windows.h>									*/
/*		#include <TextEdit.h>									*/
/*	#include <NameRegistry.h>									*/
/*	#include <CodeFragments.h>									*/

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __MACHINEEXCEPTIONS__
#include <MachineExceptions.h>
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

#define kAAPLDeviceLogicalAddress "AAPL,address"
typedef LogicalAddress *DeviceLogicalAddressPtr;


enum {
	durationMicrosecond			= -1L,							/* Microseconds are negative*/
	durationMillisecond			= 1L,							/* Milliseconds are positive*/
	durationSecond				= 1000L,						/* 1000 * durationMillisecond*/
	durationMinute				= 60000L,						/* 60 * durationSecond,*/
	durationHour				= 3600000L,						/* 60 * durationMinute,*/
	durationDay					= 86400000L,					/* 24 * durationHour,*/
	durationNoWait				= 0L,							/* don't block*/
	durationForever				= 0x7FFFFFFF					/* no time limit*/
};

enum {
	k8BitAccess					= 0,							/* access as 8 bit*/
	k16BitAccess				= 1,							/* access as 16 bit*/
	k32BitAccess				= 2								/* access as 32 bit*/
};

typedef UnsignedWide Nanoseconds;

extern OSErr IOCommandIsComplete(IOCommandID ID, OSErr result);
extern OSErr GetIOCommandInfo(IOCommandID ID, IOCommandContents *contents, IOCommandCode *command, IOCommandKind *kind);
extern void BlockCopy(const void *srcPtr, void *destPtr, Size byteCount);
extern LogicalAddress PoolAllocateResident(ByteCount byteSize, Boolean clear);
extern OSStatus PoolDeallocate(LogicalAddress address);
extern ByteCount GetLogicalPageSize(void);
extern ByteCount GetDataCacheLineSize(void);
extern OSStatus FlushProcessorCache(AddressSpaceID spaceID, LogicalAddress base, ByteCount length);
extern void SynchronizeIO(void);
extern LogicalAddress MemAllocatePhysicallyContiguous(ByteCount byteSize, Boolean clear);
extern OSStatus MemDeallocatePhysicallyContiguous(LogicalAddress address);
extern AbsoluteTime UpTime(void);
extern void GetTimeBaseInfo(UInt32 *minAbsoluteTimeDelta, UInt32 *theAbsoluteTimeToNanosecondNumerator, UInt32 *theAbsoluteTimeToNanosecondDenominator, UInt32 *theProcessorToAbsoluteTimeNumerator, UInt32 *theProcessorToAbsoluteTimeDenominator);
extern Nanoseconds AbsoluteToNanoseconds(AbsoluteTime absoluteTime);
extern Duration AbsoluteToDuration(AbsoluteTime absoluteTime);
extern AbsoluteTime NanosecondsToAbsolute(Nanoseconds nanoseconds);
extern AbsoluteTime DurationToAbsolute(Duration duration);
extern AbsoluteTime AddAbsoluteToAbsolute(AbsoluteTime absoluteTime1, AbsoluteTime absoluteTime2);
extern AbsoluteTime SubAbsoluteFromAbsolute(AbsoluteTime leftAbsoluteTime, AbsoluteTime rightAbsoluteTime);
extern AbsoluteTime AddNanosecondsToAbsolute(Nanoseconds nanoseconds, AbsoluteTime absoluteTime);
extern AbsoluteTime AddDurationToAbsolute(Duration duration, AbsoluteTime absoluteTime);
extern AbsoluteTime SubNanosecondsFromAbsolute(Nanoseconds nanoseconds, AbsoluteTime absoluteTime);
extern AbsoluteTime SubDurationFromAbsolute(Duration duration, AbsoluteTime absoluteTime);
extern Nanoseconds AbsoluteDeltaToNanoseconds(AbsoluteTime leftAbsoluteTime, AbsoluteTime rightAbsoluteTime);
extern Duration AbsoluteDeltaToDuration(AbsoluteTime leftAbsoluteTime, AbsoluteTime rightAbsoluteTime);
extern Nanoseconds DurationToNanoseconds(Duration theDuration);
extern Duration NanosecondsToDuration(Nanoseconds theNanoseconds);
extern Boolean CompareAndSwap(UInt32 oldVvalue, UInt32 newValue, UInt32 *OldValueAdr);
extern Boolean TestAndSet(UInt32 bit, UInt8 *startAddress);
extern Boolean TestAndClear(UInt32 bit, UInt8 *startAddress);
extern SInt32 IncrementAtomic(SInt32 *value);
extern SInt32 DecrementAtomic(SInt32 *value);
extern SInt32 AddAtomic(SInt32 amount, SInt32 *value);
extern UInt32 BitAndAtomic(UInt32 mask, UInt32 *value);
extern UInt32 BitOrAtomic(UInt32 mask, UInt32 *value);
extern UInt32 BitXorAtomic(UInt32 mask, UInt32 *value);
extern SInt8 IncrementAtomic8(SInt8 *value);
extern SInt8 DecrementAtomic8(SInt8 *value);
extern SInt8 AddAtomic8(SInt32 amount, SInt8 *value);
extern UInt8 BitAndAtomic8(UInt32 mask, UInt8 *value);
extern UInt8 BitOrAtomic8(UInt32 mask, UInt8 *value);
extern UInt8 BitXorAtomic8(UInt32 mask, UInt8 *value);
extern SInt16 IncrementAtomic16(SInt16 *value);
extern SInt16 DecrementAtomic16(SInt16 *value);
extern SInt16 AddAtomic16(SInt32 amount, SInt16 *value);
extern UInt16 BitAndAtomic16(UInt32 mask, UInt16 *value);
extern UInt16 BitOrAtomic16(UInt32 mask, UInt16 *value);
extern UInt16 BitXorAtomic16(UInt32 mask, UInt16 *value);
extern OSErr PBQueueInit(QHdrPtr qHeader);
extern OSErr PBQueueCreate(QHdrPtr *qHeader);
extern OSErr PBQueueDelete(QHdrPtr qHeader);
extern void PBEnqueue(QElemPtr qElement, QHdrPtr qHeader);
extern OSErr PBEnqueueLast(QElemPtr qElement, QHdrPtr qHeader);
extern OSErr PBDequeue(QElemPtr qElement, QHdrPtr qHeader);
extern OSErr PBDequeueFirst(QHdrPtr qHeader, QElemPtr *theFirstqElem);
extern OSErr PBDequeueLast(QHdrPtr qHeader, QElemPtr *theLastqElem);
extern char *CStrCopy(char *dst, const char *src);
extern StringPtr PStrCopy(StringPtr dst, ConstStr255Param src);
extern char *CStrNCopy(char *dst, const char *src, UInt32 max);
extern StringPtr PStrNCopy(StringPtr dst, ConstStr255Param src, UInt32 max);
extern char *CStrCat(char *dst, const char *src);
extern StringPtr PStrCat(StringPtr dst, ConstStr255Param src);
extern char *CStrNCat(char *dst, const char *src, UInt32 max);
extern StringPtr PStrNCat(StringPtr dst, ConstStr255Param src, UInt32 max);
extern void PStrToCStr(char *dst, ConstStr255Param src);
extern void CStrToPStr(Str255 dst, const char *src);
extern SInt16 CStrCmp(const char *s1, const char *s2);
extern SInt16 PStrCmp(ConstStr255Param str1, ConstStr255Param str2);
extern SInt16 CStrNCmp(const char *s1, const char *s2, UInt32 max);
extern SInt16 PStrNCmp(ConstStr255Param str1, ConstStr255Param str2, UInt32 max);
extern UInt32 CStrLen(const char *src);
extern UInt32 PStrLen(ConstStr255Param src);
extern OSStatus DeviceProbe(void *theSrc, void *theDest, UInt32 AccessType);
extern OSStatus DelayForHardware(AbsoluteTime absoluteTime);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __DRIVERSERVICES__ */
