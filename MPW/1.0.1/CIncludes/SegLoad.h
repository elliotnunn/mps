/*
	Segload.h - Segment Loader

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __SEGLOAD__
#define __SEGLOAD__
#ifndef __TYPES__
#include <Types.h>
#endif

#define appOpen 0
#define appPrint 1
typedef struct AppFile {
	short vRefNum;
	OSType fType;
	short versNum;
	Str255 fName;
} AppFile;
pascal void UnloadSeg(routineAddr)
	Ptr routineAddr;
	extern 0xA9F1;
pascal void ExitToShell()
	extern 0xA9F4;
#endif
