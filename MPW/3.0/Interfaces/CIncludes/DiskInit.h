/************************************************************

Created: Tuesday, October 4, 1988 at 5:45 PM
    DiskInit.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.   1985-1988 
    All rights reserved

************************************************************/


#ifndef __DISKINIT__
#define __DISKINIT__

#ifndef __TYPES__
#include <Types.h>
#endif

struct HFSDefaults {
    char sigWord[2];    /* signature word*/
    long abSize;        /* allocation block size in bytes*/
    long clpSize;       /* clump size in bytes*/
    long nxFreeFN;      /* next free file number*/
    long btClpSize;     /* B-Tree clump size in bytes*/
    short rsrv1;        /* reserved*/
    short rsrv2;        /* reserved*/
    short rsrv3;        /* reserved*/
};

#ifndef __cplusplus
typedef struct HFSDefaults HFSDefaults;
#endif

#ifdef __safe_link
extern "C" {
#endif
pascal void DILoad(void); 
pascal void DIUnload(void); 
pascal short DIBadMount(Point where,long evtMessage); 
OSErr dibadmount(Point *where,long evtMessage); 
pascal OSErr DIFormat(short drvNum); 
pascal OSErr DIVerify(short drvNum); 
pascal OSErr DIZero(short drvNum,const Str255 volName); 
OSErr dizero(short drvnum,char *volName); 
#ifdef __safe_link
}
#endif

#endif
