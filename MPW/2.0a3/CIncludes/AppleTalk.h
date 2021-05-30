/*
	AppleTalk.h -- AppleTalk Manager
	
	Version: 2.0a3
	
	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985-1987
	All rights reserved.

	modifications:
		29Jan87	KLH	changed capitalization of constants
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
	tlapRead,tlapWrite,tddpRead,tddpWrite,tnbpLookup,
	tnbpConfirm,tnbpRegister,tatpSndRequest,tatpGetRequest,
	tatpSdRsp,tatpAddRsp,tatpRequest,tatpResponse
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



/* Define __XPP__ to include new routines for File Server. */
#ifdef __XPP__		


				/* AFPCall command codes */

#define afpByteRangeLock	1
#define afpVolClose			2
#define afpDirClose			3
#define afpForkClose		4
#define afpCopyFile			5
#define afpDirCreate		6
#define afpFileCreate		7
#define afpDelete			8
#define afpEnumerate		9
#define afpFlush			10
#define afpForkFlush		11
#define afpGetDirParms		12
#define afpGetFileParms		13
#define afpGetForkParms		14
#define afpGetSInfo			15
#define afpGetSParms		16
#define afpGetVolParms		17
#define afpLogin			18
#define afpContLogin		19
#define afpLogout			20
#define afpMapID			21
#define afpMapName			22
#define afpMove				23
#define afpOpenVol			24
#define afpOpenDir			25
#define afpOpenFork			26
#define afpRead				27
#define afpRename			28
#define afpSetDirParms		29
#define afpSetFileParms		30
#define afpSetForkParms		31
#define afpSetVolParms		32
#define afpWrite			33
#define afpGetFlDrParms		34
#define afpSetFlDrParms		35

#define afpDTOpen			48
#define afpDTClose			49
#define afpGetIcon			51
#define afpGtIcnInfo		52
#define afpAddAPPL			53
#define afpRmvAPPL			54
#define afpGetAPPL			55
#define afpAddCmt			56
#define afpRmvCmt			57
#define afpGetCmt			58

#define afpAddIcon			192			/* Special code for ASP Write commands */

				/* ASP miscellaneous */

#define xppLoadedBit		5				/* XPP bit in PortBUse */
#define xppUnitNum			40				/* Unit number for XPP (old ROMs) */

#define scbMemSize			0xC0 			/* Size of memory for SCB */

#define xppFlagClr			0x00			/* constants for AFPCommandBlock */
#define xppFlagSet			0x80			/* StartEndFlag & NewLineFlag fields. */



typedef struct AFPCommandBlock {
	char		cmdByte;
	char		startEndFlag;
	int			forkRefNum;
	long		rwOffset;
	long		reqCount;
	char		newLineFlag;
	char		newLineChar;
} AFPCommandBlock;


#define XPPPBHeader \
	struct QElem	*qLink;			/* next queue entry */ \
	short			qType; 			/* queue type */ \
	short			ioTrap;			/* routine trap */ \
	Ptr				ioCmdAddr;		/* routine address */ \
	ProcPtr			ioCompletion;	/* completion routine */ \
	OSErr			ioResult;		/* result code */ \
	long			cmdResult;		/* Command result (ATP user bytes) */ \
	short			ioVRefNum;		/* volume reference or drive number */ \
	short			ioRefNum;		/* driver reference number ) */ \
	short			csCode			/* Call command code */

typedef struct XPPPrmBlk {
	XPPPBHeader;			
	short		sessRefnum;		/* Offset to session refnum */
	char		aspTimeout;		/* Timeout for ATP */
	char		aspRetry;		/* Retry count for ATP */
	int			cbSize;			/* Command block size */
	Ptr			cbPtr;			/* Command block pointer */
	int			rbSize;			/* Reply buffer size */
	Ptr			rbPtr;			/* Reply buffer pointer */
	int			wdSize;			/* Write data size */
	Ptr			wdPtr;			/* Write data pointer */
	char		ccbStart[296];	/* CCB memory allocated for driver */
								/*afpWrite max size(CCB) = 296; all other calls = 150*/
} XPPPrmBlk;
	
typedef struct AFPLoginPrm {
	XPPPBHeader;			
	short		sessRefnum;		/* Offset to session refnum */
	char		aspTimeout;		/* Timeout for ATP */
	char		aspRetry;		/* Retry count for ATP */
	int			cbSize;			/* Command block size */
	Ptr			cbPtr;			/* Command block pointer */
	int			rbSize;			/* Reply buffer size */
	Ptr			rbPtr;			/* Reply buffer pointer */
	AddrBlock	afpAddrBlock;	/* Address block in AFP login */
	Ptr			afpSCBPtr;		/* SCB pointer in AFP login */
	Ptr			afpAttnRoutine;	/* Attn routine pointer in AFP login */
	char		ccbFill[150-6];	/* CCB memory allocated for driver */
								/* Login needs only 150 bytes, BUT CCB really starts in the
								   middle of AFPSCBPtr and also clobbers AFPAttnRoutine. */
} AFPLoginPrm;
	
typedef struct ASPOpenPrm {
	XPPPBHeader;			
	short		sessRefnum;		/* Offset to session refnum */
	char		aspTimeout;		/* Timeout for ATP */
	char		aspRetry;		/* Retry count for ATP */
	AddrBlock	serverAddr;		/* Server address block */
	Ptr			scbPointer;		/* SCB pointer */
	Ptr			attnRoutine;	/* Attention routine pointer */
} ASPOpenPrm, *ASPOpenPrmPtr;
	
typedef struct ASPSizeBlk {
	XPPPBHeader;			
	int			aspMaxCmdSize;	/* For SPGetParms */
	int			aspQuantumSize;
	int			numSesss;
} ASPSizeBlk;
	
typedef struct ASPAbortPrm {
	XPPPBHeader;			
	Ptr			abortSCBPtr;	/* SCB pointer for AbortOS */
} ASPAbortPrm;

typedef union XPPParamBlock {
	struct XPPPrmBlk xppPrmBlk;
	struct ASPSizeBlk aspSizeBlk;
	struct ASPAbortPrm aspAbortPrm;
	struct ASPOpenPrm aspOpenPrm;
	struct AFPLoginPrm afpLoginPrm;
} XPPParamBlock, *XPPParmBlkPtr;


pascal OSErr OpenXPP(xppRefnum)
	int *xppRefnum;
	extern;

pascal OSErr ASPOpenSession(xParamBlock, async)
	ASPOpenPrmPtr xParamBlock;
	Boolean async;
	extern;

pascal OSErr ASPCloseSession(xParamBlock, async)
	XPPParmBlkPtr xParamBlock;
	Boolean async;
	extern;

pascal OSErr ASPAbortOS(xParamBlock, async)
	XPPParmBlkPtr xParamBlock;
	Boolean async;
	extern;

pascal OSErr ASPGetParms(xParamBlock, async)
	XPPParmBlkPtr xParamBlock;
	Boolean async;
	extern;

pascal OSErr ASPCloseAll(xParamBlock, async)
	XPPParmBlkPtr xParamBlock;
	Boolean async;
	extern;

pascal OSErr ASPUserWrite(xParamBlock, async)
	XPPParmBlkPtr xParamBlock;
	Boolean async;
	extern;

pascal OSErr ASPUserCommand(xParamBlock, async)
	XPPParmBlkPtr xParamBlock;
	Boolean async;
	extern;

pascal OSErr ASPGetStatus(xParamBlock, async)
	XPPParmBlkPtr xParamBlock;
	Boolean async;
	extern;

pascal OSErr AFPCommand(xParamBlock, async)
	XPPParmBlkPtr xParamBlock;
	Boolean async;
	extern;


#endif
#endif
