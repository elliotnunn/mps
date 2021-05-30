/*
	Devices.h - Device Manager

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __DEVICES__
#define __DEVICES__
#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#define fsAtMark 0
#define fsCurPerm 0
#define fsRdPerm 1
#define fsWrPerm 2
#define fsRdWrPerm 3
#define fsRdWrShPerm 4

#define newSelMsg 12
#define fillListMsg 13
#define getSelMsg 14
#define selectMsg 15
#define deselectMsg 16
#define terminateMsg 17
#define buttonMsg 19
#define chooserID 1


typedef struct CntrlParam {
	struct QElem *qLink;
	short qType;
	short ioTrap;
	Ptr ioCmdAddr;
	ProcPtr ioCompletion;
	OSErr ioResult;
	char *ioNamePtr;
	short ioVRefNum;
	short ioCRefNum;
	short csCode;
	short csParam[11]
} CntrlParam;
typedef struct DCtlEntry {
	Ptr dCtlDriver;
	short dCtlFlags;
	QHdr dCtlQHdr;
	long dCtlPosition;
	Handle dCtlStorage;
	short dCtlRefNum;
	long dCtlCurTicks;
	struct GrafPort *dCtlWindow;
	short dCtlDelay;
	short dCtlEMask;
	short dCtlMenu;
} DCtlEntry,*DCtlPtr,**DCtlHandle;
DCtlHandle GetDCtlEntry();

#endif
