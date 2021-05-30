/************************************************************

Created: Tuesday, October 4, 1988 at 9:36 PM
    Start.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1987-1988
    All rights reserved

************************************************************/


#ifndef __START__
#define __START__

#ifndef __TYPES__
#include <Types.h>
#endif

struct SlotDev {
    char sdExtDevID;
    char sdPartition;
    char sdSlotNum;
    char sdSRsrcID;
};

#ifndef __cplusplus
typedef struct SlotDev SlotDev;
#endif

struct SCSIDev {
    char sdReserved1;
    char sdReserved2;
    short sdRefNum;
};

#ifndef __cplusplus
typedef struct SCSIDev SCSIDev;
#endif

union DefStartRec {
    SlotDev slotDev;
    SCSIDev scsiDev;
};

#ifndef __cplusplus
typedef union DefStartRec DefStartRec;
#endif

typedef DefStartRec *DefStartPtr;

struct DefVideoRec {
    char sdSlot;
    char sdsResource;
};

#ifndef __cplusplus
typedef struct DefVideoRec DefVideoRec;
#endif

typedef DefVideoRec *DefVideoPtr;

struct DefOSRec {
    char sdReserved;
    char sdOSType;
};

#ifndef __cplusplus
typedef struct DefOSRec DefOSRec;
#endif

typedef DefOSRec *DefOSPtr;

#ifdef __safe_link
extern "C" {
#endif
pascal void GetDefaultStartup(DefStartPtr paramBlock); 
pascal void SetDefaultStartup(DefStartPtr paramBlock); 
pascal void GetVideoDefault(DefVideoPtr paramBlock); 
pascal void SetVideoDefault(DefVideoPtr paramBlock); 
pascal void GetOSDefault(DefOSPtr paramBlock); 
pascal void SetOSDefault(DefOSPtr paramBlock); 
pascal void SetTimeout(short count); 
pascal void GetTimeout(short *count); 
#ifdef __safe_link
}
#endif

#endif
