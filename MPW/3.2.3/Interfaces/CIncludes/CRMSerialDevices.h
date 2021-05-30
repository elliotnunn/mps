
/************************************************************

Created: Wednesday, September 11, 1991 at 2:05 PM
 CRMSerialDevices.h
 C Interface to the Macintosh Libraries


  Copyright Apple Computer, Inc. 1988-1991
  All rights reserved

************************************************************/


#ifndef __CRMSERIALDEVICES__
#define __CRMSERIALDEVICES__

#ifndef __TYPES__
#include <Types.h>
#endif


enum {


/*    for the crmDeviceType field of the CRMRec data structure */
 crmSerialDevice = 1,


/*  version of the CRMSerialRecord below */
 curCRMSerRecVers = 1
};

/* Maintains compatibility w/ apps & tools that expect an old style icon    */
struct CRMIconRecord {
 long oldIcon[32];	/* ICN#    */
 long oldMask[32];
 Handle theSuite;	/* Handle to an IconSuite    */
 long reserved;
};

typedef struct CRMIconRecord CRMIconRecord;
typedef CRMIconRecord *CRMIconPtr, **CRMIconHandle;

struct CRMSerialRecord {
 short version;
 StringHandle inputDriverName;
 StringHandle outputDriverName;
 StringHandle name;
 CRMIconHandle deviceIcon;
 long ratedSpeed;
 long maxSpeed;
 long reserved;
};

typedef struct CRMSerialRecord CRMSerialRecord;
typedef CRMSerialRecord *CRMSerialPtr;



#endif
