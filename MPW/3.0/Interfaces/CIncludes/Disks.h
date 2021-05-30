/************************************************************

Created: Tuesday, October 4, 1988 at 5:48 PM
    Disks.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.   1985-1988 
    All rights reserved

************************************************************/


#ifndef __DISKS__
#define __DISKS__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

struct DrvSts {
    short track;
    char writeProt;
    char diskInPlace;
    char installed;
    char sides;
    QElemPtr qLink;
    short qType;
    short dQDrive;
    short dQRefNum;
    short dQFSID;
    char twoSideFmt;
    char needsFlush;
    short diskErrs;
};

#ifndef __cplusplus
typedef struct DrvSts DrvSts;
#endif

struct DrvSts2 {
    short track;
    char writeProt;
    char diskInPlace;
    char installed;
    char sides;
    QElemPtr qLink;
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
};

#ifndef __cplusplus
typedef struct DrvSts2 DrvSts2;
#endif

#ifdef __safe_link
extern "C" {
#endif
pascal OSErr DiskEject(short drvNum); 
pascal OSErr SetTagBuffer(Ptr buffPtr); 
pascal OSErr DriveStatus(short drvNum,DrvSts *status); 
#ifdef __safe_link
}
#endif

#endif
