/************************************************************

Created: Thursday, September 7, 1989 at 3:33 PM
	DeskBus.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1987 -1989
	All rights reserved

************************************************************/


#ifndef __DESKBUS__
#define __DESKBUS__

#ifndef __TYPES__
#include <Types.h>
#endif

typedef char ADBAddress;


struct ADBOpBlock {
	Ptr dataBuffPtr;		/*address of data buffer*/
	Ptr opServiceRtPtr; 	/*service routine pointer*/
	Ptr opDataAreaPtr;		/*optional data area address*/
};

typedef struct ADBOpBlock ADBOpBlock;
typedef ADBOpBlock *ADBOpBPtr;

struct ADBDataBlock {
	char devType;			/*device type*/
	char origADBAddr;		/*original ADB Address*/
	Ptr dbServiceRtPtr; 	/*service routine pointer*/
	Ptr dbDataAreaAddr; 	/*data area address*/
};

typedef struct ADBDataBlock ADBDataBlock;
typedef ADBDataBlock *ADBDBlkPtr;

struct ADBSetInfoBlock {
	Ptr siServiceRtPtr; 	/*service routine pointer*/
	Ptr siDataAreaAddr; 	/*data area address*/
};

typedef struct ADBSetInfoBlock ADBSetInfoBlock;
typedef ADBSetInfoBlock *ADBSInfoPtr;

#ifdef __cplusplus
extern "C" {
#endif
pascal void ADBReInit(void)
	= 0xA07B;
pascal OSErr ADBOp(Ptr data,ProcPtr compRout,Ptr buffer,short commandNum);
pascal short CountADBs(void);
pascal ADBAddress GetIndADB(ADBDataBlock *info,short devTableIndex);
pascal OSErr GetADBInfo(ADBDataBlock *info,ADBAddress adbAddr); 
pascal OSErr SetADBInfo(ADBSetInfoBlock *info,ADBAddress adbAddr);
#ifdef __cplusplus
}
#endif

#endif
