/*
	Resources.h -- Resource Manager

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985-1987
	All rights reserved.
*/

#ifndef __RESOURCES__
#define __RESOURCES__
#ifndef __TYPES__
#include <Types.h>
#endif

#define resSysHeap 64
#define resPurgeable 32
#define resLocked 16
#define resProtected 8
#define resPreload 4
#define resChanged 2
#define mapReadOnly 128
#define mapCompact 64
#define mapChanged 32

pascal short InitResources()
	extern 0xA995;
pascal void RsrcZoneInit()
	extern 0xA996;
pascal void CloseResFile(refNum)
	short refNum;
	extern 0xA99A;
pascal short ResError()
	extern 0xA9AF;
pascal short CurResFile()
	extern 0xA994;
pascal short HomeResFile(theResource)
	Handle theResource;
	extern 0xA9A4;
pascal void UseResFile(refNum)
	short refNum;
	extern 0xA998;
pascal short CountTypes()
	extern 0xA99E;
pascal short Count1Types()
	extern 0xA81C;
pascal void GetIndType(theType,index)
	ResType *theType;
	short index;
	extern 0xA99F;
pascal void Get1IndType(theType,index)
	ResType *theType;
	short index;
	extern 0xA80F;
pascal void SetResLoad(load)
	Boolean load;
	extern 0xA99B;
pascal short CountResources(theType)
	ResType theType;
	extern 0xA99C;
pascal short Count1Resources(theType)
	ResType theType;
	extern 0xA80D;
pascal Handle GetIndResource(theType,index)
	ResType theType;
	short index;
	extern 0xA99D;
pascal Handle Get1IndResource(theType,index)
	ResType theType;
	short index;
	extern 0xA80E;
pascal Handle GetResource(theType,theID)
	ResType theType;
	short theID;
	extern 0xA9A0;
pascal Handle Get1Resource(theType,theID)
	ResType theType;
	short theID;
	extern 0xA81F;
extern Handle GetNamedResource();
extern Handle Get1NamedResource();
pascal void LoadResource(theResource)
	Handle theResource;
	extern 0xA9A2;
pascal void ReleaseResource(theResource)
	Handle theResource;
	extern 0xA9A3;
pascal void DetachResource(theResource)
	Handle theResource;
	extern 0xA992;
pascal short UniqueID(theType)
	ResType theType;
	extern 0xA9C1;
pascal short Unique1ID(theType)
	ResType theType;
	extern 0xA810;
pascal short GetResAttrs(theResource)
	Handle theResource;
	extern 0xA9A6;
pascal long SizeResource(theResource)
	Handle theResource;
	extern 0xA9A5;
pascal long MaxSizeRsrc(theResource)
	Handle theResource;
	extern 0xA821;
pascal long RsrcMapEntry(theResource)
	Handle theResource;
	extern 0xA9C5;
pascal void SetResAttrs(theResource,attrs)
	Handle theResource;
	short attrs;
	extern 0xA9A7;
pascal void ChangedResource(theResource)
	Handle theResource;
	extern 0xA9AA;
pascal void RmveResource(theResource)
	Handle theResource;
	extern 0xA9AD;
pascal void UpdateResFile(refNum)
	short refNum;
	extern 0xA999;
pascal void WriteResource(theResource)
	Handle theResource;
	extern 0xA9B0;
pascal void SetResPurge(install)
	Boolean install;
	extern 0xA993;
pascal short GetResFileAttrs(refNum)
	short refNum;
	extern 0xA9F6;
pascal void SetResFileAttrs(refNum,attrs)
	short refNum;
	short attrs;
	extern 0xA9F7;



/* Define __ALLNU__ to include routines for Macintosh SE or II. */
#ifdef __ALLNU__		


pascal Handle RGetResource(theType, theID)
	ResType theType;
	short theID;
	extern 0xA08C;

#endif
#endif
