
/************************************************************

Created: Friday, September 13, 1991 at 12:26 PM
 Disks.h
 C Interface to the Macintosh Libraries


  Copyright Apple Computer, Inc.  1985-1991
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
 short track;		/*current track*/
 char writeProt;	/*bit 7 = 1 if volume is locked*/
 char diskInPlace;	/*disk in drive*/
 char installed;	/*drive installed*/
 char sides;		/*-1 for 2-sided, 0 for 1-sided*/
 QElemPtr qLink;	/*next queue entry*/
 short qType;		/*1 for HD20*/
 short dQDrive;		/*drive number*/
 short dQRefNum;	/*driver reference number*/
 short dQFSID;		/*file system ID*/
 char twoSideFmt;	/*after 1st rd/wrt: 0=1 side, -1=2 side*/
 char needsFlush;	/*-1 for MacPlus drive*/
 short diskErrs;	/*soft error count*/
};

typedef struct DrvSts DrvSts;

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

typedef struct DrvSts2 DrvSts2;


#ifdef __cplusplus
extern "C" {
#endif
pascal OSErr DiskEject(short drvNum); 
pascal OSErr SetTagBuffer(void *buffPtr); 
pascal OSErr DriveStatus(short drvNum,DrvSts *status); 
#ifdef __cplusplus
}
#endif

#endif
