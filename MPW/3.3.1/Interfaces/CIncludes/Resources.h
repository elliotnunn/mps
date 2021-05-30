/*
	File:		Resources.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __RESOURCES__
#define __RESOURCES__

#ifndef __TYPES__
#include <Types.h>
/*	#include <ConditionalMacros.h>								*/
/*	#include <MixedMode.h>										*/
/*		#include <Traps.h>										*/
#endif

#ifndef __FILES__
#include <Files.h>
/*	#include <OSUtils.h>										*/
/*	#include <SegLoad.h>										*/
#endif

enum  {
	resSysHeap					= 64,							/*System or application heap?*/
	resPurgeable				= 32,							/*Purgeable resource?*/
	resLocked					= 16,							/*Load it in locked?*/
	resProtected				= 8,							/*Protected?*/
	resPreload					= 4,							/*Load in on OpenResFile?*/
	resChanged					= 2,							/*Resource changed?*/
	mapReadOnly					= 128,							/*Resource file read-only*/
	mapCompact					= 64,							/*Compact resource file*/
	mapChanged					= 32,							/*Write map out at updat*/
	kResFileNotOpened			= -1,							/*ref num return as error when opening a resourc file*/
	kSystemResFile				= 0								/*this is the default ref num to the system file*/
};


/*
	ResErrProcs cannot be written in or called from a high-level 
	language without the help of mixed mode or assembly glue because they 
	use the following parameter-passing convention:

	typedef pascal void (*ResErrProcPtr)(OSErr error);

		In:
			=> 	parameter				D0.W
		Out:
			none
*/

enum  {
	uppResErrProcInfo			= kRegisterBased|REGISTER_ROUTINE_PARAMETER(1,kRegisterD0,SIZE_CODE(sizeof(OSErr)))
};

#if USESROUTINEDESCRIPTORS
typedef pascal void (*ResErrProcPtr)(OSErr error);

typedef UniversalProcPtr ResErrUPP;

#define CallResErrProc(userRoutine, parameter)  \
	CallUniversalProc((UniversalProcPtr)(userRoutine), uppResErrProcInfo, (parameter))

#define NewResErrProc(userRoutine)  \
	(ResErrUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppResErrProcInfo, GetCurrentISA())

#else
typedef ProcPtr ResErrUPP;

#define NewResErrProc(userRoutine)  \
	(ResErrUPP)(userRoutine)

#endif

#ifdef __cplusplus
extern "C" {
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
extern Handle getnamedresource(ResType theType, char *name);
extern pascal void WriteResource(Handle theResource)
 ONEWORDINLINE(0xA9B0);
extern pascal void SetResPurge(Boolean install)
 ONEWORDINLINE(0xA993);
extern Handle get1namedresource(ResType theType, char *name);
extern pascal short GetResFileAttrs(short refNum)
 ONEWORDINLINE(0xA9F6);
extern pascal void SetResFileAttrs(short refNum, short attrs)
 ONEWORDINLINE(0xA9F7);
extern pascal short OpenRFPerm(ConstStr255Param fileName, short vRefNum, char permission)
 ONEWORDINLINE(0xA9C4);
extern pascal Handle RGetResource(ResType theType, short theID)
 ONEWORDINLINE(0xA80C);
#if SystemSevenOrLater
extern pascal short HOpenResFile(short vRefNum, long dirID, ConstStr255Param fileName, char permission)
 ONEWORDINLINE(0xA81A);
#else
extern pascal short HOpenResFile(short vRefNum, long dirID, ConstStr255Param fileName, char permission);
#endif

#if SystemSevenOrLater
extern pascal void HCreateResFile(short vRefNum, long dirID, ConstStr255Param fileName)
 ONEWORDINLINE(0xA81B);
#else
extern pascal void HCreateResFile(short vRefNum, long dirID, ConstStr255Param fileName);
#endif

extern pascal short FSpOpenResFile(const FSSpec *spec, SignedByte permission)
 THREEWORDINLINE(0x303C, 0x000D, 0xAA52);
extern pascal void FSpCreateResFile(const FSSpec *spec, OSType creator, OSType fileType, ScriptCode scriptTag)
 THREEWORDINLINE(0x303C, 0x000E, 0xAA52);

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

#if USESCODEFRAGMENTS
extern void TempInsertROMMap(Boolean tempResLoad);
#else
#define TempInsertROMMap(tempResLoad)  \
	((tempResLoad) ? *(unsigned short*)0x0B9E = 0xFFFF :  \
	*(unsigned short*)0x0B9E = 0xFF00)

#endif

extern short openrfperm(char *fileName, short vRefNum, char permission);
extern short openresfile(char *fileName);
extern void createresfile(char *fileName);
extern void getresinfo(Handle theResource, short *theID, ResType *theType, char *name);
extern void setresinfo(Handle theResource, short theID, char *name);
extern void addresource(Handle theResource, ResType theType, short theID, char *name);
#if OLDROUTINENAMES
#define SizeResource(theResource) GetResourceSizeOnDisk(theResource)

#define MaxSizeRsrc(theResource) GetMaxResourceSize(theResource)

#define RmveResource(theResource) RemoveResource(theResource)

#endif

#ifdef __cplusplus
}
#endif

#endif

