/************************************************************

Created: Tuesday, October 4, 1988 at 5:02 PM
    AppleTalk.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc. 1985-1988
    All rights reserved.

************************************************************/


#ifndef __APPLETALK__
#define __APPLETALK__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#define afpByteRangeLock 1      /*AFPCall command codes*/
#define afpVolClose 2           /*AFPCall command codes*/
#define afpDirClose 3           /*AFPCall command codes*/
#define afpForkClose 4          /*AFPCall command codes*/
#define afpCopyFile 5           /*AFPCall command codes*/
#define afpDirCreate 6          /*AFPCall command codes*/
#define afpFileCreate 7         /*AFPCall command codes*/
#define afpDelete 8             /*AFPCall command codes*/
#define afpEnumerate 9          /*AFPCall command codes*/
#define afpFlush 10             /*AFPCall command codes*/
#define afpForkFlush 11         /*AFPCall command codes*/
#define afpGetDirParms 12       /*AFPCall command codes*/
#define afpGetFileParms 13      /*AFPCall command codes*/
#define afpGetForkParms 14      /*AFPCall command codes*/
#define afpGetSInfo 15          /*AFPCall command codes*/
#define afpGetSParms 16         /*AFPCall command codes*/
#define afpGetVolParms 17       /*AFPCall command codes*/
#define afpLogin 18             /*AFPCall command codes*/
#define afpContLogin 19         /*AFPCall command codes*/
#define afpLogout 20            /*AFPCall command codes*/
#define afpMapID 21             /*AFPCall command codes*/
#define afpMapName 22           /*AFPCall command codes*/
#define afpMove 23              /*AFPCall command codes*/
#define afpOpenVol 24           /*AFPCall command codes*/
#define afpOpenDir 25           /*AFPCall command codes*/
#define afpOpenFork 26          /*AFPCall command codes*/
#define afpRead 27              /*AFPCall command codes*/
#define afpRename 28            /*AFPCall command codes*/
#define afpSetDirParms 29       /*AFPCall command codes*/
#define afpSetFileParms 30      /*AFPCall command codes*/
#define afpSetForkParms 31      /*AFPCall command codes*/
#define afpSetVolParms 32       /*AFPCall command codes*/
#define afpWrite 33             /*AFPCall command codes*/
#define afpGetFlDrParms 34      /*AFPCall command codes*/
#define afpSetFlDrParms 35      /*AFPCall command codes*/
#define afpDTOpen 48            /*AFPCall command codes*/
#define afpDTClose 49           /*AFPCall command codes*/
#define afpGetIcon 51           /*AFPCall command codes*/
#define afpGtIcnInfo 52         /*AFPCall command codes*/
#define afpAddAPPL 53           /*AFPCall command codes*/
#define afpRmvAPPL 54           /*AFPCall command codes*/
#define afpGetAPPL 55           /*AFPCall command codes*/
#define afpAddCmt 56            /*AFPCall command codes*/
#define afpRmvCmt 57            /*AFPCall command codes*/
#define afpGetCmt 58            /*AFPCall command codes*/
#define afpAddIcon 192          /*Special code for ASP Write commands*/
#define xppLoadedBit 5          /* XPP bit in PortBUse */
#define xppUnitNum 40           /*Unit number for XPP (old ROMs) */
#define xppRefNum -41           /*.XPP reference number */
#define scbMemSize 192          /*Size of memory for SCB */
#define xppFlagClr 0            /*Cs for AFPCommandBlock */
#define xppFlagSet 128          /*StartEndFlag & NewLineFlag fields. */
#define lapSize 20
#define ddpSize 26
#define nbpSize 26
#define atpSize 56
#define MPPioCompletion MPP.ioCompletion
#define MPPioResult MPP.ioResult
#define MPPioRefNum MPP.ioRefNum
#define MPPcsCode MPP.csCode
#define LAPprotType LAP.protType
#define LAPwdsPointer LAP.LAPptrs.wdsPointer
#define LAPhandler LAP.LAPptrs.handler
#define DDPsocket DDP.socket
#define DDPchecksumFlag DDP.checksumFlag
#define DDPwdsPointer DDP.DDPptrs.wdsPointer
#define DDPlistener DDP.DDPptrs.listener
#define NBPinterval NBP.interval
#define NBPcount NBP.count
#define NBPntQElPtr NBP.NBPPtrs.ntQElPtr
#define NBPentityPtr NBP.NBPPtrs.entityPtr
#define NBPverifyFlag NBP.parm.verifyFlag
#define NBPretBuffPtr NBP.parm.Lookup.retBuffPtr
#define NBPretBuffSize NBP.parm.Lookup.retBuffSize
#define NBPmaxToGet NBP.parm.Lookup.maxToGet
#define NBPnumGotten NBP.parm.Lookup.numGotten
#define NBPconfirmAddr NBP.parm.Confirm.confirmAddr
#define NBPnKillQEl NBPKILL.nKillQEl
#define NBPnewSocket NBP.parm.Confirm.newSocket
#define ATPioCompletion ATP.ioCompletion
#define ATPioResult ATP.ioResult
#define ATPuserData ATP.userData
#define ATPreqTID ATP.reqTID
#define ATPioRefNum ATP.ioRefNum
#define ATPcsCode ATP.csCode
#define ATPatpSocket ATP.atpSocket
#define ATPatpFlags ATP.atpFlags
#define ATPaddrBlock ATP.addrBlock
#define ATPreqLength ATP.reqLength
#define ATPreqPointer ATP.reqPointer
#define ATPbdsPointer ATP.bdsPointer
#define ATPtimeOutVal SREQ.timeOutVal
#define ATPnumOfResps SREQ.numOfResps
#define ATPretryCount SREQ.retryCount
#define ATPnumOfBuffs OTH1.u0.numOfBuffs
#define ATPbitMap OTH1.u0.bitMap
#define ATPrspNum OTH1.u0.rspNum
#define ATPbdsSize OTH2.bdsSize
#define ATPtransID OTH2.transID
#define ATPaKillQEl KILL.aKillQEl
#define atpXOvalue 32           /*ATP exactly-once bit */
#define atpEOMvalue 16          /*ATP End-Of-Message bit */
#define atpSTSvalue 8           /*ATP Send-Transmission-Status bit */
#define atpTIDValidvalue 2      /*ATP trans. ID valid bit */
#define atpSendChkvalue 1       /*ATP send checksum bit */

enum {tLAPRead,tLAPWrite,tDDPRead,tDDPWrite,tNBPLookup,tNBPConfirm,tNBPRegister,
    tATPSndRequest,tATPGetRequest,tATPSdRsp,tATPAddRsp,tATPRequest,tATPResponse};
typedef unsigned char ABCallType;

enum {lapProto,ddpProto,nbpProto,atpProto};
typedef unsigned char ABProtoType;

typedef unsigned char ABByte;

typedef char BitMapType;

typedef char Str32[33];

struct LAPAdrBlock {
    unsigned char dstNodeID;
    unsigned char srcNodeID;
    ABByte lapProtType;
};

#ifndef __cplusplus
typedef struct LAPAdrBlock LAPAdrBlock;
#endif

struct AddrBlock {
    short aNet;
    unsigned char aNode;
    unsigned char aSocket;
};

#ifndef __cplusplus
typedef struct AddrBlock AddrBlock;
#endif

struct EntityName {
    Str32 objStr;
    char pad1;                  /*Str32's aligned on even word boundries.*/
    Str32 typeStr;
    char pad2;
    Str32 zoneStr;
    char pad3;
};

#ifndef __cplusplus
typedef struct EntityName EntityName;
#endif

typedef EntityName *EntityPtr;

/* Real definition of EntityName is 3 PACKED strings of any length (32 is just an example). No
offests for Asm since each String address must be calculated by adding length byte to last string ptr. 
In Pascal, String(32) will be 34 bytes long since fields never start on an odd byte unless they are 
only a byte long. So this will generate correct looking interfaces for Pascal and C, but they will not 
be the same, which is OK since they are not used. */
struct RetransType {
    unsigned char retransInterval;
    unsigned char retransCount;
};

#ifndef __cplusplus
typedef struct RetransType RetransType;
#endif

struct BDSElement {
    short buffSize;
    Ptr buffPtr;
    short dataSize;
    long userBytes;
};

#ifndef __cplusplus
typedef struct BDSElement BDSElement;
#endif

typedef BDSElement BDSType[8];
typedef BDSType *BDSPtr;


struct ATLAPRec {
    ABCallType abOpcode;
    short abResult;
    long abUserReference;
    LAPAdrBlock lapAddress;
    short lapReqCount;
    short lapActCount;
    Ptr lapDataPtr;
};

#ifndef __cplusplus
typedef struct ATLAPRec ATLAPRec;
#endif

typedef ATLAPRec *ATLAPRecPtr, **ATLAPRecHandle;

struct ATDDPRec {
    ABCallType abOpcode;
    short abResult;
    long abUserReference;
    short ddpType;
    short ddpSocket;
    AddrBlock ddpAddress;
    short ddpReqCount;
    short ddpActCount;
    Ptr ddpDataPtr;
    short ddpNodeID;
};

#ifndef __cplusplus
typedef struct ATDDPRec ATDDPRec;
#endif

typedef ATDDPRec *ATDDPRecPtr, **ATDDPRecHandle;

struct ATNBPRec {
    ABCallType abOpcode;
    short abResult;
    long abUserReference;
    EntityPtr nbpEntityPtr;
    Ptr nbpBufPtr;
    short nbpBufSize;
    short nbpDataField;
    AddrBlock nbpAddress;
    RetransType nbpRetransmitInfo;
};

#ifndef __cplusplus
typedef struct ATNBPRec ATNBPRec;
#endif

typedef ATNBPRec *ATNBPRecPtr, **ATNBPRecHandle;

struct ATATPRec {
    ABCallType abOpcode;
    short abResult;
    long abUserReference;
    short atpSocket;
    AddrBlock atpAddress;
    short atpReqCount;
    Ptr atpDataPtr;
    BDSPtr atpRspBDSPtr;
    BitMapType atpBitMap;
    short atpTransID;
    short atpActCount;
    long atpUserData;
    Boolean atpXO;
    Boolean atpEOM;
    short atpTimeOut;
    short atpRetries;
    short atpNumBufs;
    short atpNumRsp;
    short atpBDSSize;
    long atpRspUData;
    Ptr atpRspBuf;
    short atpRspSize;
};

#ifndef __cplusplus
typedef struct ATATPRec ATATPRec;
#endif

typedef ATATPRec *ATATPRecPtr, **ATATPRecHandle;

typedef struct {
    char cmdByte;
    char startEndFlag;
    short forkRefNum;
    long rwOffset;
    long reqCount;
    char newLineFlag;
    char newLineChar;
}AFPCommandBlock;

#define XPPPBHeader \
    QElem *qLink;\
    short qType;\
    short ioTrap;\
    Ptr ioCmdAddr;\
    ProcPtr ioCompletion;\
    OSErr ioResult;\
    long cmdResult;\
    short ioVRefNum;\
    short ioRefNum;\
    short csCode;


typedef struct {
    XPPPBHeader 
    short sessRefnum;           /*Offset to session refnum*/
    char aspTimeout;            /*Timeout for ATP*/
    char aspRetry;              /*Retry count for ATP*/
    short cbSize;               /*Command block size*/
    Ptr cbPtr;                  /*Command block pointer*/
    short rbSize;               /*Reply buffer size*/
    Ptr rbPtr;                  /*Reply buffer pointer*/
    short wdSize;               /*Write Data size*/
    Ptr wdPtr;                  /*Write Data pointer*/
    char ccbStart[296];         /*CCB memory allocated for driver afpWrite max size(CCB)=296 all other calls=150*/
}XPPPrmBlk;

typedef struct {
    XPPPBHeader 
    short sessRefnum;           /*Offset to session refnum */
    char aspTimeout;            /*Timeout for ATP */
    char aspRetry;              /*Retry count for ATP */
    short cbSize;               /*Command block size */
    Ptr cbPtr;                  /*Command block pointer */
    short rbSize;               /*Reply buffer size */
    Ptr rbPtr;                  /*Reply buffer pointer */
    AddrBlock afpAddrBlock;     /*block in AFP login */
    Ptr afpSCBPtr;              /*SCB pointer in AFP login */
    Ptr afpAttnRoutine;         /*routine pointer in AFP login */
    char ccbFill[144];          /*CCB memory allocated for driver  Login needs only 150 bytes BUT CCB really starts in the middle of AFPSCBPtr and also clobbers AFPAttnRoutine. */
}AFPLoginPrm;

typedef struct {
    XPPPBHeader 
    short sessRefnum;           /*Offset to session refnum */
    char aspTimeout;            /*Timeout for ATP */
    char aspRetry;              /*Retry count for ATP */
    AddrBlock serverAddr;       /*Server address block */
    Ptr scbPointer;             /*SCB pointer */
    Ptr attnRoutine;            /*Attention routine pointer*/
}ASPOpenPrm;

typedef ASPOpenPrm *ASPOpenPrmPtr;

typedef struct {
    XPPPBHeader 
    Ptr abortSCBPtr;            /*SCB pointer for AbortOS */
}ASPAbortPrm;

typedef struct {
    XPPPBHeader 
    short aspMaxCmdSize;        /*For SPGetParms*/
    short aspQuantumSize;
    short numSesss;
}ASPGetparmsBlk;

typedef struct {
    short entryLength;
    Ptr entryPtr;
}WDSElement;

typedef struct {
    AddrBlock nteAddress;       /*network address of entity*/
    char filler;
    char entityData[99];        /*Object, Type & Zone*/
}NTElement;

typedef struct {
    Ptr qNext;                  /*ptr to next NTE*/
    NTElement nt;
}NamesTableEntry;

#define MPPATPHeader \
    QElem *qLink;               /*next queue entry*/\
    short qType;                /*queue type*/\
    short ioTrap;               /*routine trap*/\
    Ptr ioCmdAddr;              /*routine address*/\
    ProcPtr ioCompletion;       /*completion routine*/\
    OSErr ioResult;             /*result code*/\
    long userData;              /*Command result (ATP user bytes)*/\
    short reqTID;               /*request transaction ID*/\
    short ioRefNum;             /*driver reference number*/\
    short csCode;               /*Call command code*/


typedef struct {
    MPPATPHeader 
}MPPparms;

typedef struct {
    MPPATPHeader 
    char protType;              /*ALAP protocol Type */
    char filler;
    union {
        Ptr wdsPointer;         /*-> write data structure*/
        Ptr handler;            /*-> protocol handler routine*/
        } LAPptrs;
}LAPparms;

typedef struct {
    MPPATPHeader 
    char socket;                /*socket number */
    char checksumFlag;          /*check sum flag */
    union {
        Ptr wdsPointer;         /*-> write data structure*/
        Ptr listener;           /*->write data structure or -> Listener*/
        } DDPptrs;
}DDPparms;

typedef struct {
    MPPATPHeader 
    char interval;              /*retry interval */
    char count;                 /*retry count */
    union {
        Ptr ntQElPtr;
        Ptr entityPtr;
        } NBPPtrs;
    union {
        char verifyFlag;
        struct {
            Ptr retBuffPtr;
            short retBuffSize;
            short maxToGet;
            short numGotten;
            } Lookup;
        struct {
            AddrBlock confirmAddr;
            char newSocket;
            } Confirm;
        } parm;
}NBPparms;

typedef struct {
    MPPATPHeader 
    char newSelfFlag;           /*self-send toggle flag */
    char oldSelfFlag;           /*previous self-send state */
}SetSelfparms;

typedef struct {
    MPPATPHeader 
    Ptr nKillQEl;               /*ptr to i/o queue element to cancel */
}NBPKillparms;

typedef union {
    MPPparms MPP;               /*General MPP parms*/
    LAPparms LAP;               /*ALAP calls*/
    DDPparms DDP;               /*DDP calls*/
    NBPparms NBP;               /*NBP calls*/
    SetSelfparms SETSELF ;
    NBPKillparms NBPKILL ;
}MPPParamBlock;

typedef MPPParamBlock *MPPPBPtr;

#define MOREATPHeader \
    char atpSocket;             /*currbitmap for requests or ATP socket number*/\
    char atpFlags;              /*control information*/\
    AddrBlock addrBlock;        /*source/dest. socket address*/\
    short reqLength;            /*request/response length*/\
    Ptr reqPointer;             /*->request/response Data*/\
    Ptr bdsPointer;             /*->response BDS */


typedef struct {
    MPPATPHeader 
    MOREATPHeader 
}ATPparms;

typedef struct {
    MPPATPHeader 
    MOREATPHeader 
    char filler;                /*numOfBuffs */
    char timeOutVal;            /*timeout interval */
    char numOfResps;            /*number of responses actually received */
    char retryCount;            /*number of retries */
    short intBuff;              /*used internally for NSendRequest */
}SendReqparms;

typedef struct {
    MPPATPHeader 
    MOREATPHeader 
    union {
        char bitMap;            /*bitmap received */
        char numOfBuffs;        /*number of responses being sent*/
        char rspNum;            /*sequence number*/
        } u0;
}ATPmisc1;

typedef struct {
    MPPATPHeader 
    MOREATPHeader 
    char filler;
    char bdsSize;               /*number of BDS elements */
    short transID;              /*transaction ID recd. */
}ATPmisc2;

typedef struct {
    MPPATPHeader 
    MOREATPHeader 
    Ptr aKillQEl;               /*ptr to i/o queue element to cancel*/
}Killparms;

typedef union {
    ATPparms ATP;               /*General ATP parms*/
    SendReqparms SREQ;          /*sendrequest parms*/
    ATPmisc1 OTH1;              /*and a few others*/
    ATPmisc2 OTH2;              /*and a few others*/
    Killparms KILL;             /*and a few others */
}ATPParamBlock;

typedef ATPParamBlock *ATPPBPtr;

typedef union {
    XPPPrmBlk XPP;
    ASPGetparmsBlk GETPARM;
    ASPAbortPrm ABORT;
    ASPOpenPrm OPEN;
    AFPLoginPrm LOGIN;
}XPPParamBlock;

typedef XPPParamBlock *XPPParmBlkPtr;

#ifdef __safe_link
extern "C" {
#endif
pascal OSErr OpenXPP(short *xppRefnum); 
pascal OSErr ASPOpenSession(ASPOpenPrmPtr thePBptr,Boolean async); 
pascal OSErr ASPCloseSession(XPPParmBlkPtr thePBptr,Boolean async); 
pascal OSErr ASPAbortOS(XPPParmBlkPtr thePBptr,Boolean async); 
pascal OSErr ASPGetParms(XPPParmBlkPtr thePBptr,Boolean async); 
pascal OSErr ASPCloseAll(XPPParmBlkPtr thePBptr,Boolean async); 
pascal OSErr ASPUserWrite(XPPParmBlkPtr thePBptr,Boolean async); 
pascal OSErr ASPUserCommand(XPPParmBlkPtr thePBptr,Boolean async); 
pascal OSErr ASPGetStatus(XPPParmBlkPtr thePBptr,Boolean async); 
pascal OSErr AFPCommand(XPPParmBlkPtr thePBptr,Boolean async); 
pascal OSErr PAttachPH(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr PDetachPH(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr PWriteLAP(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr POpenSkt(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr PCloseSkt(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr PWriteDDP(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr PRegisterName(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr PLookupName(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr PConfirmName(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr PRemoveName(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr PSetSelfSend(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr PKillNBP(MPPPBPtr thePBptr,Boolean async); 
pascal OSErr POpenATPSkt(ATPPBPtr thePBptr,Boolean async); 
pascal OSErr PCloseATPSkt(ATPPBPtr thePBPtr,Boolean async); 
pascal OSErr PSendRequest(ATPPBPtr thePBPtr,Boolean async); 
pascal OSErr PGetRequest(ATPPBPtr thePBPtr,Boolean async); 
pascal OSErr PSendResponse(ATPPBPtr thePBPtr,Boolean async); 
pascal OSErr PAddResponse(ATPPBPtr thePBPtr,Boolean async); 
pascal OSErr PRelTCB(ATPPBPtr thePBPtr,Boolean async); 
pascal OSErr PRelRspCB(ATPPBPtr thePBPtr,Boolean async); 
pascal OSErr PNSendRequest(ATPPBPtr thePBPtr,Boolean async); 
pascal OSErr PKillSendReq(ATPPBPtr thePBPtr,Boolean async); 
pascal OSErr PKillGetReq(ATPPBPtr thePBPtr,Boolean async); 
pascal void BuildLAPwds(Ptr wdsPtr,Ptr dataPtr,short destHost,short prototype,
    short frameLen); 
pascal void BuildDDPwds(Ptr wdsPtr,Ptr headerPtr,Ptr dataPtr,const AddrBlock *netAddr,
    short ddpType,short dataLen); 
pascal void NBPSetEntity(Ptr buffer,Ptr nbpObject,Ptr nbpType,Ptr nbpZone); 
pascal void NBPSetNTE(Ptr ntePtr,Ptr nbpObject,Ptr nbpType,Ptr nbpZone,
    short socket); 
pascal short GetBridgeAddress(void); 
pascal short BuildBDS(Ptr buffPtr,Ptr bdsPtr,short buffSize); 
pascal OSErr MPPOpen(void); 
pascal OSErr MPPClose(void); 
pascal OSErr LAPOpenProtocol(ABByte theLAPType,Ptr protoPtr); 
pascal OSErr LAPCloseProtocol(ABByte theLAPType); 
pascal OSErr LAPWrite(ATLAPRecHandle abRecord,Boolean async); 
pascal OSErr LAPRead(ATLAPRecHandle abRecord,Boolean async); 
pascal OSErr LAPRdCancel(ATLAPRecHandle abRecord); 
pascal OSErr DDPOpenSocket(short *theSocket,Ptr sktListener); 
pascal OSErr DDPCloseSocket(short theSocket); 
pascal OSErr DDPRead(ATDDPRecHandle abRecord,Boolean retCksumErrs,Boolean async); 
pascal OSErr DDPWrite(ATDDPRecHandle abRecord,Boolean doChecksum,Boolean async); 
pascal OSErr DDPRdCancel(ATDDPRecHandle abRecord); 
pascal OSErr ATPLoad(void); 
pascal OSErr ATPUnload(void); 
pascal OSErr ATPOpenSocket(const AddrBlock *addrRcvd,short *atpSocket); 
pascal OSErr ATPCloseSocket(short atpSocket); 
pascal OSErr ATPSndRequest(ATATPRecHandle abRecord,Boolean async); 
pascal OSErr ATPRequest(ATATPRecHandle abRecord,Boolean async); 
pascal OSErr ATPReqCancel(ATATPRecHandle abRecord,Boolean async); 
pascal OSErr ATPGetRequest(ATATPRecHandle abRecord,Boolean async); 
pascal OSErr ATPSndRsp(ATATPRecHandle abRecord,Boolean async); 
pascal OSErr ATPAddRsp(ATATPRecHandle abRecord); 
pascal OSErr ATPResponse(ATATPRecHandle abRecord,Boolean async); 
pascal OSErr ATPRspCancel(ATATPRecHandle abRecord,Boolean async); 
pascal OSErr NBPRegister(ATNBPRecHandle abRecord,Boolean async); 
pascal OSErr NBPLookup(ATNBPRecHandle abRecord,Boolean async); 
pascal OSErr NBPExtract(Ptr theBuffer,short numInBuf,short whichOne,EntityName *abEntity,
    AddrBlock *address); 
pascal OSErr NBPConfirm(ATNBPRecHandle abRecord,Boolean async); 
pascal OSErr NBPRemove(EntityPtr abEntity); 
pascal OSErr NBPLoad(void); 
pascal OSErr NBPUnload(void); 
pascal void RemoveHdlBlocks(void); 
pascal OSErr GetNodeAddress(short *myNode,short *myNet); 
pascal Boolean IsMPPOpen(void); 
pascal Boolean IsATPOpen(void); 
#ifdef __safe_link
}
#endif

#endif