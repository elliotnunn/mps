/************************************************************

Created: Thursday, October 27, 1988 at 10:13 PM
    Devices.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.   1985-1988
    All rights reserved

************************************************************/


#ifndef __DEVICES__
#define __DEVICES__

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#define newSelMsg 12
#define fillListMsg 13
#define getSelMsg 14
#define selectMsg 15
#define deselectMsg 16
#define terminateMsg 17
#define buttonMsg 19
#define chooserID 1
#define initDev 0       /*Time for cdev to initialize itself*/
#define hitDev 1        /*Hit on one of my items*/
#define closeDev 2      /*Close yourself*/
#define nulDev 3        /*Null event*/
#define updateDev 4     /*Update event*/
#define activDev 5      /*Activate event*/
#define deactivDev 6    /*Deactivate event*/
#define keyEvtDev 7     /*Key down/auto key*/
#define macDev 8        /*Decide whether or not to show up*/
#define undoDev 9
#define cutDev 10
#define copyDev 11
#define pasteDev 12
#define clearDev 13
#define cdevGenErr -1   /*General error; gray cdev w/o alert*/
#define cdevMemErr 0    /*Memory shortfall; alert user please*/
#define cdevResErr 1    /*Couldn't get a needed resource; alert*/
#define cdevUnset 3     /* cdevValue is initialized to this*/

struct DCtlEntry {
    Ptr dCtlDriver;
    short dCtlFlags;
    QHdr dCtlQHdr;
    long dCtlPosition;
    Handle dCtlStorage;
    short dCtlRefNum;
    long dCtlCurTicks;
    WindowPtr dCtlWindow;
    short dCtlDelay;
    short dCtlEMask;
    short dCtlMenu;
};

#ifndef __cplusplus
typedef struct DCtlEntry DCtlEntry;
#endif

typedef DCtlEntry *DCtlPtr, **DCtlHandle;

struct AuxDCE {
    Ptr dCtlDriver;
    short dCtlFlags;
    QHdr dCtlQHdr;
    long dCtlPosition;
    Handle dCtlStorage;
    short dCtlRefNum;
    long dCtlCurTicks;
    GrafPtr dCtlWindow;
    short dCtlDelay;
    short dCtlEMask;
    short dCtlMenu;
    char dCtlSlot;
    char dCtlSlotId;
    long dCtlDevBase;
    Ptr dCtlOwner;
    char dCtlExtDev;
    char fillByte;
};

#ifndef __cplusplus
typedef struct AuxDCE AuxDCE;
#endif

typedef AuxDCE *AuxDCEPtr, **AuxDCEHandle;

#ifdef __safe_link
extern "C" {
#endif
pascal DCtlHandle GetDCtlEntry(short refNum); 
pascal Boolean SetChooserAlert(Boolean f); 
pascal OSErr OpenDriver(const Str255 name,short *drvrRefNum); 
OSErr opendriver(char *driverName,short *refNum); 
pascal OSErr CloseDriver(short refNum); 
pascal OSErr Control(short refNum,short csCode,Ptr csParamPtr); 
pascal OSErr Status(short refNum,short csCode,Ptr csParamPtr); 
pascal OSErr KillIO(short refNum); 
pascal OSErr PBControl(ParmBlkPtr paramBlock,Boolean aSync); 
pascal OSErr PBStatus(ParmBlkPtr paramBlock,Boolean aSync); 
pascal OSErr PBKillIO(ParmBlkPtr paramBlock,Boolean aSync); 
#ifdef __safe_link
}
#endif

#endif
