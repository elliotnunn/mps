/************************************************************

Created: Thursday, September 7, 1989 at 7:44 PM
	Start.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1987-1989
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

typedef struct SlotDev SlotDev;
struct SCSIDev {
	char sdReserved1;
	char sdReserved2;
	short sdRefNum;
};

typedef struct SCSIDev SCSIDev;
union DefStartRec {
	SlotDev slotDev;
	SCSIDev scsiDev;
};

typedef union DefStartRec DefStartRec;

typedef DefStartRec *DefStartPtr;

struct DefVideoRec {
	char sdSlot;
	char sdsResource;
};

typedef struct DefVideoRec DefVideoRec;
typedef DefVideoRec *DefVideoPtr;

struct DefOSRec {
	char sdReserved;
	char sdOSType;
};

typedef struct DefOSRec DefOSRec;
typedef DefOSRec *DefOSPtr;

#ifdef __cplusplus
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
#ifdef __cplusplus
}
#endif

#endif
