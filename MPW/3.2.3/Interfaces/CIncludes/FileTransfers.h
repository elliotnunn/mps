
/************************************************************

Created: Wednesday, September 11, 1991 at 6:06 PM
 FileTransfers.h
 C Interface to the Macintosh Libraries


  Copyright Apple Computer, Inc. 1988-1991
  All rights reserved

************************************************************/


#ifndef __FILETRANSFERS__
#define __FILETRANSFERS__

#ifndef __PACKAGES__
#include <Packages.h>
#endif

#ifndef __CTBUTILITIES__
#include <CTBUtilities.h>
#endif

#ifndef __CONNECTIONS__
#include <Connections.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif


enum {


/* current file transfer manager version */
 curFTVersion = 2,

/* FTErr    */
 ftGenericError = -1,
 ftNoErr = 0,
 ftRejected = 1,
 ftFailed = 2,
 ftTimeOut = 3,
 ftTooManyRetry = 4,
 ftNotEnoughDSpace = 5,
 ftRemoteCancel = 6,
 ftWrongFormat = 7,
 ftNoTools = 8,
 ftUserCancel = 9,
 ftNotSupported = 10
};

typedef OSErr FTErr;

enum {ftIsFTMode = 1 << 0,ftNoMenus = 1 << 1,ftQuiet = 1 << 2,ftConfigChanged = 1 << 4,
 ftSucc = 1 << 7};
typedef unsigned long FTFlags;

enum {ftSameCircuit = 1 << 0,ftSendDisable = 1 << 1,ftReceiveDisable = 1 << 2,
 ftTextOnly = 1 << 3,ftNoStdFile = 1 << 4,ftMultipleFileSend = 1 << 5};
typedef unsigned short FTAttributes;

enum {ftReceiving,ftTransmitting};
typedef unsigned short FTDirection;


struct FTRecord {
 short procID;
 FTFlags flags;
 FTErr errCode;
 long refCon;
 long userData;
 ProcPtr defProc;
 Ptr config;
 Ptr oldConfig;
 ProcPtr environsProc;
 long reserved1;
 long reserved2;
 Ptr ftPrivate;
 ProcPtr sendProc;
 ProcPtr recvProc;
 ProcPtr writeProc;
 ProcPtr readProc;
 WindowPtr owner;
 FTDirection direction;
 SFReply theReply;
 long writePtr;
 long readPtr;
 char *theBuf;
 long bufSize;
 Str255 autoRec;
 FTAttributes attributes;
};

typedef struct FTRecord FTRecord;
typedef FTRecord *FTPtr, **FTHandle;


enum {


/* FTReadProc messages */
 ftReadOpenFile = 0,	/* count = forkFlags, buffer = pblock from PBGetFInfo */
 ftReadDataFork = 1,
 ftReadRsrcFork = 2,
 ftReadAbort = 3,
 ftReadComplete = 4,
 ftReadSetFPos = 6,		/* count = forkFlags, buffer = pBlock same as PBSetFPos */
 ftReadGetFPos = 7,		/* count = forkFlags, buffer = pBlock same as PBGetFPos */

/* FTWriteProc messages */
 ftWriteOpenFile = 0,	/* count = forkFlags, buffer = pblock from PBGetFInfo */
 ftWriteDataFork = 1,
 ftWriteRsrcFork = 2,
 ftWriteAbort = 3,
 ftWriteComplete = 4,
 ftWriteFileInfo = 5,
 ftWriteSetFPos = 6,	/* count = forkFlags, buffer = pBlock same as PBSetFPos */
 ftWriteGetFPos = 7,	/* count = forkFlags, buffer = pBlock same as PBGetFPos */

/* fork flags */
 ftOpenDataFork = 1,
 ftOpenRsrcFork = 2

};

/* application routines type definitions */
typedef pascal OSErr (*FileTransferReadProcPtr) (unsigned long *count, Ptr pData, long refCon, short fileMsg);
typedef pascal OSErr (*FileTransferWriteProcPtr) (unsigned long *count, Ptr pData, long refCon, short fileMsg);

typedef pascal Size (*FileTransferSendProcPtr) (Ptr thePtr, long theSize, long refCon, CMChannel channel, CMFlags flag);
typedef pascal Size (*FileTransferReceiveProcPtr) (Ptr thePtr, long theSize, long refCon, CMChannel channel, CMFlags *flag);

typedef pascal OSErr (*FileTransferEnvironsProcPtr) (long refCon, ConnEnvironRec *theEnvirons);

typedef pascal void  (*FileTransferNotificationProcPtr) (FTHandle hFT, FSSpecPtr pFSSpec);
typedef pascal void  (*FileTransferChooseIdleProcPtr) (void);

#ifdef __cplusplus
extern "C" {
#endif
pascal FTErr InitFT(void); 
pascal Handle FTGetVersion(FTHandle hFT); 
pascal short FTGetFTVersion(void); 

pascal FTHandle FTNew(short procID,FTFlags flags,FileTransferSendProcPtr sendProc,
 FileTransferReceiveProcPtr recvProc,FileTransferReadProcPtr readProc,FileTransferWriteProcPtr writeProc,
 FileTransferEnvironsProcPtr environsProc,WindowPtr owner,long refCon,long userData); 

pascal void FTDispose(FTHandle hFT); 

pascal FTErr FTStart(FTHandle hFT,FTDirection direction,const SFReply *fileInfo); 
pascal FTErr FTAbort(FTHandle hFT); 

pascal FTErr FTSend(FTHandle hFT,short numFiles,FSSpecArrayPtr pFSSpec,
 FileTransferNotificationProcPtr notifyProc); 
pascal FTErr FTReceive(FTHandle hFT,FSSpecPtr pFSSpec,FileTransferNotificationProcPtr notifyProc); 

pascal void FTExec(FTHandle hFT); 

pascal void FTActivate(FTHandle hFT,Boolean activate); 
pascal void FTResume(FTHandle hFT,Boolean resume); 
pascal Boolean FTMenu(FTHandle hFT,short menuID,short item); 

pascal short FTChoose(FTHandle *hFT,Point where,FileTransferChooseIdleProcPtr idleProc); 
pascal void FTEvent(FTHandle hFT,const EventRecord *theEvent); 

pascal Boolean FTValidate(FTHandle hFT); 
pascal void FTDefault(Ptr *theConfig,short procID,Boolean allocate); 

pascal Handle FTSetupPreflight(short procID,long *magicCookie); 
pascal void FTSetupSetup(short procID,const void *theConfig,short count,
 DialogPtr theDialog,long *magicCookie); 
pascal Boolean FTSetupFilter(short procID,const void *theConfig,short count,
 DialogPtr theDialog,EventRecord *theEvent,short *theItem,long *magicCookie); 
pascal void FTSetupItem(short procID,const void *theConfig,short count,
 DialogPtr theDialog,short *theItem,long *magicCookie); 
pascal void FTSetupXCleanup(short procID,const void *theConfig,short count,
 DialogPtr theDialog,Boolean OKed,long *magicCookie); 

pascal void FTSetupPostflight(short procID); 

pascal Ptr FTGetConfig(FTHandle hFT); 
pascal short FTSetConfig(FTHandle hFT,const void *thePtr); 

pascal OSErr FTIntlToEnglish(FTHandle hFT,const void *inputPtr,Ptr *outputPtr,
 short language); 
pascal OSErr FTEnglishToIntl(FTHandle hFT,const void *inputPtr,Ptr *outputPtr,
 short language); 

pascal void FTGetToolName(short procID,Str255 name); 
pascal short FTGetProcID(ConstStr255Param name); 

pascal void FTSetRefCon(FTHandle hFT,long refCon); 
pascal long FTGetRefCon(FTHandle hFT); 

pascal void FTSetUserData(FTHandle hFT,long userData); 
pascal long FTGetUserData(FTHandle hFT); 

pascal void FTGetErrorString(FTHandle hFT,short id,Str255 errMsg); 
#ifdef __cplusplus
}
#endif

#endif
