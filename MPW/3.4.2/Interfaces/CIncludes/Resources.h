/*
 	File:		Resources.h
 
 	Contains:	Resource Manager Interfaces.
 
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

#ifndef __RESOURCES__
#define __RESOURCES__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif
/*	#include <OSUtils.h>										*/
/*		#include <Memory.h>										*/
/*	#include <Finder.h>											*/

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
	resSysHeap					= 64,							/*System or application heap?*/
	resPurgeable				= 32,							/*Purgeable resource?*/
	resLocked					= 16,							/*Load it in locked?*/
	resProtected				= 8,							/*Protected?*/
	resPreload					= 4,							/*Load in on OpenResFile?*/
	resChanged					= 2,							/*Resource changed?*/
	mapReadOnly					= 128,							/*Resource file read-only*/
	mapCompact					= 64,							/*Compact resource file*/
	mapChanged					= 32,							/*Write map out at update*/
	resSysRefBit				= 7,							/*reference to system/local reference*/
	resSysHeapBit				= 6,							/*In system/in application heap*/
	resPurgeableBit				= 5,							/*Purgeable/not purgeable*/
	resLockedBit				= 4,							/*Locked/not locked*/
	resProtectedBit				= 3,							/*Protected/not protected*/
	resPreloadBit				= 2,							/*Read in at OpenResource?*/
	resChangedBit				= 1,							/*Existing resource changed since last update*/
	mapReadOnlyBit				= 7,							/*is this file read-only?*/
	mapCompactBit				= 6,							/*Is a compact necessary?*/
	mapChangedBit				= 5,							/*Is it necessary to write map?*/
	kResFileNotOpened			= -1,							/*ref num return as error when opening a resource file*/
	kSystemResFile				= 0								/*this is the default ref num to the system file*/
};

/*
		ResErrProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal void (*ResErrProcPtr)(OSErr thErr);

		In:
		 => thErr       	D0.W
*/

#if GENERATINGCFM
typedef UniversalProcPtr ResErrUPP;
#else
typedef Register68kProcPtr ResErrUPP;
#endif

enum {
	uppResErrProcInfo = kRegisterBased
		 | REGISTER_ROUTINE_PARAMETER(1, kRegisterD0, SIZE_CODE(sizeof(OSErr)))
};

#if GENERATINGCFM
#define NewResErrProc(userRoutine)		\
		(ResErrUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppResErrProcInfo, GetCurrentArchitecture())
#else
#define NewResErrProc(userRoutine)		\
		((ResErrUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallResErrProc(userRoutine, thErr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppResErrProcInfo, (thErr))
#else
/* (*ResErrProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
#endif

extern pascal short InitResources(void)
 ONEWORDINLINE(0xA995);
extern pascal void RsrcZoneInit(void)
 ONEWORDINLINE(0xA996);
extern pascal void CloseResFile(short refNum)
 ONEWORDINLINE(0xA99A);
extern pascal short ResError(void)
 ONEWORDINLINE(0xA9AF);
extern pascal short CurResFile(void)
 ONEWORDINLINE(0xA994);
extern pascal short HomeResFile(Handle theResource)
 ONEWORDINLINE(0xA9A4);
extern pascal void CreateResFile(ConstStr255Param fileName)
 ONEWORDINLINE(0xA9B1);
extern pascal short OpenResFile(ConstStr255Param fileName)
 ONEWORDINLINE(0xA997);
extern pascal void UseResFile(short refNum)
 ONEWORDINLINE(0xA998);
extern pascal short CountTypes(void)
 ONEWORDINLINE(0xA99E);
extern pascal short Count1Types(void)
 ONEWORDINLINE(0xA81C);
extern pascal void GetIndType(ResType *theType, short index)
 ONEWORDINLINE(0xA99F);
extern pascal void Get1IndType(ResType *theType, short index)
 ONEWORDINLINE(0xA80F);
extern pascal void SetResLoad(Boolean load)
 ONEWORDINLINE(0xA99B);
extern pascal short CountResources(ResType theType)
 ONEWORDINLINE(0xA99C);
extern pascal short Count1Resources(ResType theType)
 ONEWORDINLINE(0xA80D);
extern pascal Handle GetIndResource(ResType theType, short index)
 ONEWORDINLINE(0xA99D);
extern pascal Handle Get1IndResource(ResType theType, short index)
 ONEWORDINLINE(0xA80E);
extern pascal Handle GetResource(ResType theType, short theID)
 ONEWORDINLINE(0xA9A0);
extern pascal Handle Get1Resource(ResType theType, short theID)
 ONEWORDINLINE(0xA81F);
extern pascal Handle GetNamedResource(ResType theType, ConstStr255Param name)
 ONEWORDINLINE(0xA9A1);
extern pascal Handle Get1NamedResource(ResType theType, ConstStr255Param name)
 ONEWORDINLINE(0xA820);
extern pascal void LoadResource(Handle theResource)
 ONEWORDINLINE(0xA9A2);
extern pascal void ReleaseResource(Handle theResource)
 ONEWORDINLINE(0xA9A3);
extern pascal void DetachResource(Handle theResource)
 ONEWORDINLINE(0xA992);
extern pascal short UniqueID(ResType theType)
 ONEWORDINLINE(0xA9C1);
extern pascal short Unique1ID(ResType theType)
 ONEWORDINLINE(0xA810);
extern pascal short GetResAttrs(Handle theResource)
 ONEWORDINLINE(0xA9A6);
extern pascal void GetResInfo(Handle theResource, short *theID, ResType *theType, Str255 name)
 ONEWORDINLINE(0xA9A8);
extern pascal void SetResInfo(Handle theResource, short theID, ConstStr255Param name)
 ONEWORDINLINE(0xA9A9);
extern pascal void AddResource(Handle theData, ResType theType, short theID, ConstStr255Param name)
 ONEWORDINLINE(0xA9AB);
extern pascal long GetResourceSizeOnDisk(Handle theResource)
 ONEWORDINLINE(0xA9A5);
extern pascal long GetMaxResourceSize(Handle theResource)
 ONEWORDINLINE(0xA821);
extern pascal long RsrcMapEntry(Handle theResource)
 ONEWORDINLINE(0xA9C5);
extern pascal void SetResAttrs(Handle theResource, short attrs)
 ONEWORDINLINE(0xA9A7);
extern pascal void ChangedResource(Handle theResource)
 ONEWORDINLINE(0xA9AA);
extern pascal void RemoveResource(Handle theResource)
 ONEWORDINLINE(0xA9AD);
extern pascal void UpdateResFile(short refNum)
 ONEWORDINLINE(0xA999);
extern pascal void WriteResource(Handle theResource)
 ONEWORDINLINE(0xA9B0);
extern pascal void SetResPurge(Boolean install)
 ONEWORDINLINE(0xA993);
extern pascal short GetResFileAttrs(short refNum)
 ONEWORDINLINE(0xA9F6);
extern pascal void SetResFileAttrs(short refNum, short attrs)
 ONEWORDINLINE(0xA9F7);
extern pascal short OpenRFPerm(ConstStr255Param fileName, short vRefNum, SInt8 permission)
 ONEWORDINLINE(0xA9C4);
extern pascal Handle RGetResource(ResType theType, short theID)
 ONEWORDINLINE(0xA80C);
#if SystemSevenOrLater
extern pascal short HOpenResFile(short vRefNum, long dirID, ConstStr255Param fileName, SInt8 permission)
 ONEWORDINLINE(0xA81A);
#else
extern pascal short HOpenResFile(short vRefNum, long dirID, ConstStr255Param fileName, SInt8 permission);
#endif
#if SystemSevenOrLater
extern pascal void HCreateResFile(short vRefNum, long dirID, ConstStr255Param fileName)
 ONEWORDINLINE(0xA81B);
#else
extern pascal void HCreateResFile(short vRefNum, long dirID, ConstStr255Param fileName);
#endif
extern pascal short FSpOpenResFile(const FSSpec *spec, SignedByte permission)
 TWOWORDINLINE(0x700D, 0xAA52);
extern pascal void FSpCreateResFile(const FSSpec *spec, OSType creator, OSType fileType, ScriptCode scriptTag)
 TWOWORDINLINE(0x700E, 0xAA52);
/*  partial resource calls  */
extern pascal void ReadPartialResource(Handle theResource, long offset, void *buffer, long count)
 TWOWORDINLINE(0x7001, 0xA822);
extern pascal void WritePartialResource(Handle theResource, long offset, const void *buffer, long count)
 TWOWORDINLINE(0x7002, 0xA822);
extern pascal void SetResourceSize(Handle theResource, long newSize)
 TWOWORDINLINE(0x7003, 0xA822);
extern pascal Handle GetNextFOND(Handle fondHandle)
 TWOWORDINLINE(0x700A, 0xA822);
/* Use TempInsertROMMap to force the ROM resource map to be
   inserted into the chain in front of the system. Note that
   this call is only temporary - the modified resource chain
   is only used for the next call to the resource manager.
   See IM IV 19 for more information. */
extern pascal void TempInsertROMMap(Boolean tempResLoad);
#if CGLUESUPPORTED
extern Handle getnamedresource(ResType theType, const char *name);
extern Handle get1namedresource(ResType theType, const char *name);
extern short openrfperm(const char *fileName, short vRefNum, char permission);
extern short openresfile(const char *fileName);
extern void createresfile(const char *fileName);
extern void getresinfo(Handle theResource, short *theID, ResType *theType, char *name);
extern void setresinfo(Handle theResource, short theID, const char *name);
extern void addresource(Handle theResource, ResType theType, short theID, const char *name);
#endif
#if OLDROUTINENAMES
#define SizeResource(theResource) GetResourceSizeOnDisk(theResource)
#define MaxSizeRsrc(theResource) GetMaxResourceSize(theResource)
#define RmveResource(theResource) RemoveResource(theResource)
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

#endif /* __RESOURCES__ */
