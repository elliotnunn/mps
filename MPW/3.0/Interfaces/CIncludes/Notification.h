/************************************************************

Created: Tuesday, October 4, 1988 at 7:03 PM
    Notification.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1988
    All rights reserved

************************************************************/


#ifndef __NOTIFICATION__
#define __NOTIFICATION__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#define nmType 8

struct NMRec {
    QElemPtr qLink;     /*next queue entry*/
    short qType;        /*queue type -- ORD(nmType) = 8*/
    short nmFlags;      /*reserved*/
    long nmPrivate;     /*reserved*/
    short nmReserved;   /*reserved*/
    short nmMark;       /*item to mark in Apple menu*/
    Handle nmSIcon;     /*handle to small icon*/
    Handle nmSound;     /*handle to sound record*/
    StringPtr nmStr;    /*string to appear in alert*/
    ProcPtr nmResp;     /*pointer to response routine*/
    long nmRefCon;      /*for application use*/
};

#ifndef __cplusplus
typedef struct NMRec NMRec;
#endif

#ifdef __safe_link
extern "C" {
#endif
pascal OSErr NMInstall(QElemPtr nmReqPtr)
    = {0x205F,0xA05E,0x3E80}; 
pascal OSErr NMRemove(QElemPtr nmReqPtr)
    = {0x205F,0xA05F,0x3E80}; 
#ifdef __safe_link
}
#endif

#endif
