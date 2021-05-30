/************************************************************

Created: Wednesday, September 13, 1989 at 3:34 PM
	Resources.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __RESOURCES__
#define __RESOURCES__

#ifndef __TYPES__
#include <Types.h>
#endif

#define resSysHeap 64		/*System or application heap?*/
#define resPurgeable 32 	/*Purgeable resource?*/
#define resLocked 16		/*Load it in locked?*/
#define resProtected 8		/*Protected?*/
#define resPreload 4		/*Load in on OpenResFile?*/
#define resChanged 2		/*Resource changed?*/
#define mapReadOnly 128 	/*Resource file read-only*/
#define mapCompact 64		/*Compact resource file*/
#define mapChanged 32		/*Write map out at updat*/

/* Values for setting RomMapInsert and TmpResLoad */

#define mapTrue 0xFFFF		/*insert ROM map w/ TmpResLoad = TRUE.*/
#define mapFalse 0xFF00 	/*insert ROM map w/ TmpResLoad = FALSE.*/

#ifdef __cplusplus
extern "C" {
#endif
pascal short InitResources(void)
	= 0xA995;
pascal void RsrcZoneInit(void)
	= 0xA996;
pascal void CloseResFile(short refNum)
	= 0xA99A;
pascal short ResError(void)
	= 0xA9AF;
pascal short CurResFile(void)
	= 0xA994;
pascal short HomeResFile(Handle theResource)
	= 0xA9A4;
pascal void CreateResFile(const Str255 fileName)
	= 0xA9B1;
pascal short OpenResFile(const Str255 fileName)
	= 0xA997;
pascal void UseResFile(short refNum)
	= 0xA998;
pascal short CountTypes(void)
	= 0xA99E;
pascal short Count1Types(void)
	= 0xA81C;
pascal void GetIndType(ResType *theType,short index)
	= 0xA99F;
pascal void Get1IndType(ResType *theType,short index)
	= 0xA80F;
pascal void SetResLoad(Boolean load)
	= 0xA99B;
pascal short CountResources(ResType theType)
	= 0xA99C;
pascal short Count1Resources(ResType theType)
	= 0xA80D;
pascal Handle GetIndResource(ResType theType,short index)
	= 0xA99D;
pascal Handle Get1IndResource(ResType theType,short index)
	= 0xA80E;
pascal Handle GetResource(ResType theType,short theID)
	= 0xA9A0;
pascal Handle Get1Resource(ResType theType,short theID)
	= 0xA81F;
pascal Handle GetNamedResource(ResType theType,const Str255 name)
	= 0xA9A1;
pascal Handle Get1NamedResource(ResType theType,const Str255 name)
	= 0xA820;
pascal void LoadResource(Handle theResource)
	= 0xA9A2;
pascal void ReleaseResource(Handle theResource)
	= 0xA9A3;
pascal void DetachResource(Handle theResource)
	= 0xA992;
pascal short UniqueID(ResType theType)
	= 0xA9C1;
pascal short Unique1ID(ResType theType)
	= 0xA810;
pascal short GetResAttrs(Handle theResource)
	= 0xA9A6;
pascal void GetResInfo(Handle theResource,short *theID,ResType *theType,
	Str255 name)
	= 0xA9A8;
pascal void SetResInfo(Handle theResource,short theID,const Str255 name)
	= 0xA9A9;
pascal void AddResource(Handle theResource,ResType theType,short theID,
	const Str255 name)
	= 0xA9AB;
pascal long SizeResource(Handle theResource)
	= 0xA9A5;
pascal long MaxSizeRsrc(Handle theResource)
	= 0xA821;
pascal long RsrcMapEntry(Handle theResource)
	= 0xA9C5;
pascal void SetResAttrs(Handle theResource,short attrs)
	= 0xA9A7;
pascal void ChangedResource(Handle theResource)
	= 0xA9AA;
pascal void RmveResource(Handle theResource)
	= 0xA9AD;
pascal void UpdateResFile(short refNum)
	= 0xA999;
Handle getnamedresource(ResType theType,char *name);
pascal void WriteResource(Handle theResource)
	= 0xA9B0;
pascal void SetResPurge(Boolean install)
	= 0xA993;
Handle get1namedresource(ResType theType,char *name);
pascal short GetResFileAttrs(short refNum)
	= 0xA9F6;
pascal void SetResFileAttrs(short refNum,short attrs)
	= 0xA9F7;
pascal short OpenRFPerm(const Str255 fileName,short vRefNum,char permission)
	= 0xA9C4;
pascal Handle RGetResource(ResType theType,short theID)
	= 0xA80C;
pascal short HOpenResFile(short vRefNum,long dirID,const Str255 fileName,
	char permission);
pascal void HCreateResFile(short vRefNum,long dirID,const Str255 fileName); 
short openrfperm(char *fileName,short vRefNum,char permission); 
short openresfile(char *fileName);
void createresfile(char *fileName); 
void getresinfo(Handle theResource,short *theID,ResType *theType,char *name);
void setresinfo(Handle theResource,short theID,char *name); 
void addresource(Handle theResource,ResType theType,short theID,char *name);
#ifdef __cplusplus
}
#endif

#endif
