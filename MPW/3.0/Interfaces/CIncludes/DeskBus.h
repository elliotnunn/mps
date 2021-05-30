/************************************************************

Created: Tuesday, October 4, 1988 at 5:31 PM
    DeskBus.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1987 -1988
    All rights reserved

************************************************************/


#ifndef __DESKBUS__
#define __DESKBUS__

#ifndef __TYPES__
#include <Types.h>
#endif

typedef char ADBAddress;


struct ADBOpBlock {
    Ptr dataBuffPtr;        /*address of data buffer*/
    Ptr opServiceRtPtr;     /*service routine pointer*/
    Ptr opDataAreaPtr;      /*optional data area address*/
};

#ifndef __cplusplus
typedef struct ADBOpBlock ADBOpBlock;
#endif

typedef ADBOpBlock *ADBOpBPtr;

struct ADBDataBlock {
    char devType;           /*device type*/
    char origADBAddr;       /*original ADB Address*/
    Ptr dbServiceRtPtr;     /*service routine pointer*/
    Ptr dbDataAreaAddr;     /*data area address*/
};

#ifndef __cplusplus
typedef struct ADBDataBlock ADBDataBlock;
#endif

typedef ADBDataBlock *ADBDBlkPtr;

struct ADBSetInfoBlock {
    Ptr siServiceRtPtr;     /*service routine pointer*/
    Ptr siDataAreaAddr;     /*data area address*/
};

#ifndef __cplusplus
typedef struct ADBSetInfoBlock ADBSetInfoBlock;
#endif

typedef ADBSetInfoBlock *ADBSInfoPtr;

#ifdef __safe_link
extern "C" {
#endif
pascal void ADBReInit(void)
    = 0xA07B; 
pascal OSErr ADBOp(Ptr data,ProcPtr compRout,Ptr buffer,short commandNum); 
pascal short CountADBs(void); 
pascal ADBAddress GetIndADB(ADBDataBlock *info,short devTableIndex); 
pascal OSErr GetADBInfo(ADBDataBlock *info,ADBAddress adbAddr); 
pascal OSErr SetADBInfo(ADBSetInfoBlock *info,ADBAddress adbAddr); 
#ifdef __safe_link
}
#endif

#endif
