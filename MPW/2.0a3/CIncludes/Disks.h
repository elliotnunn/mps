/*
	Disks.h -- Disk Driver

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __DISKS__
#define __DISKS__
#ifndef __TYPES__
#include <Types.h>
#endif

typedef struct DrvSts {
	short track;
	char writeProt;
	char diskInPlace;
	char installed;
	char sides;
	struct QElem *qLink;
	short qType;
	short dQDrive;
	short dQRefNum;
	short dQFSID;
	char twoSideFmt;
	char needsFlush;
	short diskErrs;
} DrvSts;
typedef struct DrvSts2 {
	short track;
	char writeProt;
	char diskInPlace;
	char installed;
	char sides;
	struct QElem *qLink;
	short qType;
	short dQDrive;
	short dQRefNum;
	short dQFSID;
	short driveSize;
	short driveS1;
	short driveType;
	short driveManf;
	short driveChar;
	char driveMisc;
} DrvSts2;
#endif
