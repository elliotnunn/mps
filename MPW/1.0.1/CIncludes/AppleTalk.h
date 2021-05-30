/*
	AppleTalk.h -- AppleTalk Manager

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __APPLETALK__
#define __APPLETALK__
#ifndef __TYPES__
#include <Types.h>
#endif

#define lapSize 20
#define ddpSize 26
#define nbpSize 26
#define atpSize 56

typedef enum {
	tLAPRead,tLAPWrite,tDDPRead,tDDPWrite,tNBPLookup,
	tNBPConfirm,tNBPRegister,tATPSndRequest,tATPGetRequest,
	tATPSdRsp,tATPAddRsp,tATPRequest,tATPResponse
} ABCallType;
typedef enum {
	lapProto,ddpProto,nbpProto,atpProto
} ABProtoType;
typedef struct LAPAdrBlock {
	unsigned char dstNodeID,srcNodeID,lapProtType;
} LAPAdrBlock;
typedef struct AddrBlock {
	short aNet; unsigned char aNode,aSocket;
} AddrBlock;
typedef struct EntityName {
	String(32) objStr,typeStr,zoneStr;
} EntityName,*EntityPtr;
typedef struct RetransType {
	unsigned char retransInterval,retransCount;
} RetransType;
typedef char BitMapType;
typedef struct BDSElement {
	short buffSize;
	Ptr buffPtr;
	short dataSize;
	long userBytes;
} BDSElement,BDSType[8];
typedef BDSType *BDSPtr;
typedef struct ATLAPRec {
	ABCallType abOpcode;
	short abResult;
	long abUserReference;
	LAPAdrBlock lapAddress;
	short lapReqCount;
	short lapActCount;
	Ptr lapDataPtr;
} ATLAPRec,*ATLAPRecPtr,**ATLAPRecHandle;
typedef struct ATDDPRec {
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
} ATDDPRec,*ATDDPRecPtr,**ATDDPRecHandle;
typedef struct ATNBPRec {
	ABCallType abOpcode;
	short abResult;
	long abUserReference;
	EntityPtr nbpEntityPtr;
	Ptr nbpBufPtr;
	short nbpBufSize;
	short nbpDataField;
	AddrBlock nbpAddress;
	RetransType nbpRetransmitInfo;
} ATNBPRec,*ATNBPRecPtr,**ATNBPRecHandle;
typedef struct ATATPRec {
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
} ATATPRec,*ATATPRecPtr,**ATATPRecHandle;

pascal short MPPOpen()
	extern;
pascal short MPPClose()
	extern;
pascal short LAPOpenProtocol(theLAPType,protoPtr)
	short theLAPType;
	Ptr protoPtr;
	extern;
pascal short LAPCloseProtocol(theLAPType)
	short theLAPType;
	extern;
pascal short LAPWrite(abRecord,async)
	ATLAPRecHandle abRecord;
	Boolean async;
	extern;
pascal short LAPRead(abRecord,async)
	ATLAPRecHandle abRecord;
	Boolean async;
	extern;
pascal short LAPRdCancel(abRecord)
	ATLAPRecHandle abRecord;
	extern;
pascal short DDPOpenSocket(theSocket,sktListener)
	short *theSocket;
	Ptr sktListener;
	extern;
pascal short DDPCloseSocket(theSocket)
	short theSocket;
	extern;
pascal short DDPRead(abRecord,retCksumErrs,async)
	ATDDPRecHandle abRecord;
	Boolean retCksumErrs;
	Boolean async;
	extern;
pascal short DDPWrite(abRecord,doChecksum,async)
	ATDDPRecHandle abRecord;
	Boolean doChecksum;
	Boolean async;
	extern;
pascal short DDPRdCancel(abRecord)
	ATDDPRecHandle abRecord;
	extern;
pascal short ATPLoad() extern;
pascal short ATPUnload() extern;
pascal short ATPOpenSocket(addrRcvd,atpSocket)
	AddrBlock addrRcvd;
	short *atpSocket;
	extern;
pascal short ATPCloseSocket(atpSocket)
	short atpSocket;
	extern;
pascal short ATPSndRequest(abRecord,async)
	ATATPRecHandle abRecord;
	Boolean async;
	extern;
pascal short ATPRequest(abRecord,async)
	ATATPRecHandle abRecord;
	Boolean async;
	extern;
pascal short ATPReqCancel(abRecord,async)
	ATATPRecHandle abRecord;
	Boolean async;
	extern;
pascal short ATPGetRequest(abRecord,async)
	ATATPRecHandle abRecord;
	Boolean async;
	extern;
pascal short ATPSndRsp(abRecord,async)
	ATATPRecHandle abRecord;
	Boolean async;
	extern;
pascal short ATPAddRsp(abRecord)
	ATATPRecHandle abRecord;
	extern;
pascal short ATPResponse(abRecord,async)
	ATATPRecHandle abRecord;
	Boolean async;
	extern;
pascal short ATPRspCancel(abRecord,async)
	ATATPRecHandle abRecord;
	Boolean async;
	extern;
pascal short NBPRegister(abRecord,async)
	ATNBPRecHandle abRecord;
	Boolean async;
	extern;
pascal short NBPLookup(abRecord,async)
	ATNBPRecHandle abRecord;
	Boolean async;
	extern;
pascal short NBPExtract(theBuffer,numInBuf,whichOne,abEntity,address)
	Ptr theBuffer;
	short numInBuf;
	short whichOne;
	EntityName *abEntity;
	AddrBlock *address;
	extern;
pascal short NBPConfirm(abRecord,async)
	ATNBPRecHandle abRecord;
	Boolean async;
	extern;
pascal short NBPRemove(abEntity)
	EntityPtr abEntity;
	extern;
pascal short NBPLoad()
	extern;
pascal short NBPUnload()
	extern;
pascal void RemoveHdlBlocks()
	extern;
pascal short GetNodeAddress(myNode,myNet)
	short *myNode,*myNet;
	extern;
pascal Boolean IsMPPOpen() extern;
pascal Boolean IsATPOpen() extern;
#endif
