{
  File: AppleTalk.p

 Version: 2.0a3

 Copyright Apple Computer, Inc. 1986, 1987
 All Rights Reserved

 modifications:
	29Jan87	KLH	changed capitalization of constants
}

UNIT AppleTalk;

  INTERFACE

	USES {$U Memtypes.p } Memtypes,
	  {$U QuickDraw.p	} QuickDraw,
	  {$U OSIntf.p		} OSIntf,
	  {$U ToolIntf.p	} ToolIntf;

	CONST

	  lapSize = 20;
	  ddpSize = 26;
	  nbpSize = 26;
	  atpSize = 56;

	  {error codes}

	  ddpSktErr = - 91;
	  ddpLenErr = - 92;
	  noBridgeErr = - 93;
	  lapProtErr = - 94;
	  excessCollsns = - 95;

	  nbpBuffOvr = - 1024;
	  nbpNoConfirm = - 1025;
	  nbpConfDiff = - 1026;
	  nbpDuplicate = - 1027;
	  nbpNotFound = - 1028;
	  nbpNISErr = - 1029;

	  reqFailed = - 1096;
	  tooManyReqs = - 1097;
	  tooManySkts = - 1098;
	  badATPSkt = - 1099;
	  badBuffNum = - 1100;
	  noRelErr = - 1101;
	  cbNotFound = - 1102;
	  noSendResp = - 1103;
	  noDataArea = - 1104;
	  reqAborted = - 1105;

	  buf2SmallErr = - 3101;
	  noMPPErr = - 3102;
	  ckSumErr = - 3103;
	  extractErr = - 3104;
	  readQErr = - 3105;
	  atpLenErr = - 3106;
	  atpBadRsp = - 3107;
	  recNotFnd = - 3108;
	  sktClosedErr = - 3109;

{ New Appletalk Contstants }
				{ AFPCall command codes }

afpByteRangeLock	=	1;
afpVolClose			=	2;
afpDirClose			=	3;
afpForkClose		=	4;
afpCopyFile			=	5;
afpDirCreate		=	6;
afpFileCreate		=	7;
afpDelete			=	8;
afpEnumerate		=	9;
afpFlush			=	10;
afpForkFlush		=	11;
afpGetDirParms		=	12;
afpGetFileParms		=	13;
afpGetForkParms		=	14;
afpGetSInfo			=	15;
afpGetSParms		=	16;
afpGetVolParms		=	17;
afpLogin			=	18;
afpContLogin		=	19;
afpLogout			=	20;
afpMapID			=	21;
afpMapName			=	22;
afpMove				=	23;
afpOpenVol			=	24;
afpOpenDir			=	25;
afpOpenFork			=	26;
afpRead				=	27;
afpRename			=	28;
afpSetDirParms		=	29;
afpSetFileParms		=	30;
afpSetForkParms		=	31;
afpSetVolParms		=	32;
afpWrite			=	33;
afpGetFlDrParms		=	34;
afpSetFlDrParms		=	35;

afpDTOpen			=	48;
afpDTClose			=	49;
afpGetIcon			=	51;
afpGtIcnInfo		=	52;
afpAddAPPL			=	53;
afpRmvAPPL			=	54;
afpGetAPPL			=	55;
afpAddCmt			=	56;
afpRmvCmt			=	57;
afpGetCmt			=	58;

afpPAddIcon			=	192;		{ Special code for ASP Write commands }

				{ Error codes }

aspBadVersNum		=	-1066;		{ Server cannot support this ASP version }
aspBufTooSmall		=	-1067;		{ Buffer too small }
aspNoMoreSess		=	-1068;		{ No more sessions on server }
aspNoServers		=	-1069;		{ No servers at that address }
aspParamErr			=	-1070;		{ Parameter error }
aspServerBusy		=	-1071;		{ Server cannot open another session }
aspSessClosed		=	-1072;		{ Session closed }
aspSizeErr			=	-1073;		{ Command block too big }
aspTooMany			=	-1074;		{ Too many clients (server error) }
aspNoAck			=	-1075;		{ No ack on attention request (server err) }

afpAccessDenied     =	-5000;
afpAuthContinue     =	-5001;
afpBadUAM           =	-5002;
afpBadVersNum       =	-5003;
afpBitmapErr        =	-5004;
afpCantMove         =	-5005;
afpDenyConflict     =	-5006;
afpDirNotEmpty      =	-5007;
afpDiskFull         =	-5008;
afpEofError         =	-5009;
afpFileBusy         =	-5010;
afpFlatVol          =	-5011;
afpItemNotFound     =	-5012;
afpLockErr          =	-5013;
afpMiscErr          =	-5014;
afpNoMoreLocks      =	-5015;
afpNoServer         =	-5016;
afpObjectExists     =	-5017;
afpObjectNotFound   =	-5018;
afpParmErr          =	-5019;
afpRangeNotLocked   =	-5020;
afpRangeOverlap     =	-5021;
afpSessClosed       =	-5022;
afpUserNotAuth      =	-5023;
afpCallNotSupported =	-5024;

				{ ASP miscellaneous }

xppLoadedBit		=	5;				{ XPP bit in PortBUse }
xppUnitNum			=	40;				{ Unit number for XPP (old ROMs) }

scbMemSize			=	$C0; 			{ Size of memory for SCB }

xppFlagClr			=	$00;			{ constants for AFPCommandBlock }
xppFlagSet			=	$80;			{ StartEndFlag & NewLineFlag fields. }



	TYPE

	  ABByte = 1..127;

	  STR32 = STRING[32];

	  ABCallType = (tlapRead, tlapWrite, tddpRead, tddpWrite, tnbpLookUp,
					tnbpConfirm, tnbpRegister, tatpSndRequest, tatpGetRequest,
					tatpSdRsp, tatpAddRsp, tatpRequest, tatpResponse);

	  ABProtoType = (lapProto, ddpProto, nbpProto, atpProto);

	  LAPAdrBlock = PACKED RECORD
					  dstNodeID: Byte;
					  srcNodeID: Byte;
					  LAPProtType: ABByte;
					END;

	  AddrBlock = PACKED RECORD
					aNet: INTEGER;
					aNode: Byte;
					aSocket: Byte;
				  END;

	  EntityName = RECORD
					 objStr: STR32;
					 typeStr: STR32;
					 zoneStr: STR32;
				   END;

	  EntityPtr = ^EntityName;

	  RetransType = PACKED RECORD
					  retransInterval: Byte;
					  retransCount: Byte;
					END;

	  BitMapType = PACKED ARRAY [0..7] OF BOOLEAN;

	  BDSElement = RECORD
					 buffSize: INTEGER;
					 buffPtr: Ptr;
					 dataSize: INTEGER;
					 userBytes: LongInt;
				   END;

	  BDSType = ARRAY [0..7] OF BDSElement;

	  BDSPtr = ^BDSType;

	  ABusRecord = RECORD
					 abOpCode: ABCallType;
					 abResult: INTEGER;
					 abUserReference: LongInt;

					 CASE ABProtoType OF
					   lapProto:
						 (lapAddress: LAPAdrBlock;
						  lapReqCount: INTEGER;
						  lapActCount: INTEGER;
						  lapDataPtr: Ptr; );

					   ddpProto:
						 (ddpType: Byte;
						  ddpSocket: Byte;
						  ddpAddress: AddrBlock;
						  ddpReqCount: INTEGER;
						  ddpActCount: INTEGER;
						  ddpDataPtr: Ptr;
						  ddpNodeID: Byte; );

					   nbpProto:
						 (nbpEntityPtr: EntityPtr;
						  nbpBufPtr: Ptr;
						  nbpBufSize: INTEGER;
						  nbpDataField: INTEGER;
						  nbpAddress: AddrBlock;
						  nbpRetransmitInfo: RetransType; );

					   atpProto:

						 (atpSocket: Byte;
						  atpAddress: AddrBlock;
						  atpReqCount: INTEGER;
						  atpDataPtr: Ptr;
						  atpRspBDSPtr: BDSPtr;
						  atpBitMap: BitMapType;
						  atpTransID: INTEGER;
						  atpActCount: INTEGER;
						  atpUserData: LongInt;
						  atpXO: BOOLEAN;
						  atpEOM: BOOLEAN;
						  atpTimeOut: Byte;
						  atpRetries: Byte;
						  atpNumBufs: Byte;
						  atpNumRsp: Byte;
						  atpBDSSize: Byte;

						  atpRspUData: LongInt;
						  atpRspBuf: Ptr;
						  atpRspSize: INTEGER; );

				   END; {record}

	  ABRecPtr = ^ABusRecord;
	  ABRecHandle = ^ABRecPtr;

{ New AppleTalk TYPEs }

AFPCommandBlock = PACKED RECORD
	cmdByte:		Byte;
	startEndFlag:	Byte;
	forkRefNum:		INTEGER;
	rwOffset:		LONGINT;
	reqCount:		LONGINT;
	newLineFlag:	Byte;
	newLineChar:	CHAR;
END;    { AFPCommandBlock }

XPPPrmBlkType = (XPPPrmBlk, ASPSizeBlk, ASPAbortPrm);
XPPSubPrmType = (ASPOpenPrm, ASPSubPrm);
XPPEndPrmType = (AFPLoginPrm, ASPEndPrm);

XPPParamBlock = PACKED RECORD
	qLink:			QElemPtr;			{ next queue entry }
	qType:			INTEGER;			{ queue type }
	ioTrap:			INTEGER;			{ routine trap }
	ioCmdAddr:		Ptr;				{ routine address }
	ioCompletion:	ProcPtr;			{ completion routine }
	ioResult:		OSErr;				{ result code }
	cmdResult:		LONGINT;			{ Command result (ATP user bytes) [long] }
	ioVRefNum:		INTEGER;			{ volume reference or drive number }
	ioRefNum:		INTEGER;			{ driver reference number }
	csCode:			INTEGER;			{ Call command code }
	CASE XPPPrmBlkType OF
	  ASPAbortPrm:
		(abortSCBPtr:	Ptr);			{ SCB pointer for AbortOS [long] }
	  ASPSizeBlk:
		(aspMaxCmdSize:	INTEGER;		{ For SPGetParms [word] }
		aspQuantumSize:	INTEGER;		{ For SPGetParms [word] }
		numSesss:		INTEGER);		{ For SPGetParms [word] }
	  XPPPrmBlk:
		(sessRefnum:	INTEGER;		{ Offset to session refnum [word] }
		aspTimeout:		Byte;			{ Timeout for ATP [byte] }
		aspRetry:		Byte;			{ Retry count for ATP [byte] }
		CASE XPPSubPrmType OF
		  ASPOpenPrm:
			(serverAddr:	AddrBlock;	{ Server address block [longword] }
			scbPointer:		Ptr;		{ SCB pointer [longword] }
			attnRoutine:	Ptr);		{ Attention routine pointer [long] }
		  ASPSubPrm:
			(cbSize:		INTEGER;	{ Command block size [word] }
			cbPtr:			Ptr;		{ Command block pointer [long] }
			rbSize:			INTEGER;	{ Reply buffer size [word] }
			rbPtr:			Ptr;		{ Reply buffer pointer [long] }
			CASE XPPEndPrmType OF
			  AFPLoginPrm:
				(afpAddrBlock:	AddrBlock;	{ Address block in AFP login [long] }
				afpSCBPtr:		Ptr;		{ SCB pointer in AFP login [long] }
				afpAttnRoutine:	Ptr);		{ Attn routine pointer in AFP login }
			  ASPEndPrm:
				(wdSize:		INTEGER;	{ Write data size [word] }
				wdPtr:			Ptr;		{ Write data pointer [long] }
				ccbStart: 		ARRAY[0..295] OF Byte)));	{ CCB memory allocated for driver }
				{afpWrite max size(CCB) = 296; all other calls = 150}
END;    { XPPParamBlock }

XPPParmBlkPtr = ^XPPParamBlock;  		{ Pointer to an XPP record }



	FUNCTION LAPOpenProtocol(theLAPType: ABByte; protoPtr: Ptr): OsErr;

	FUNCTION LAPCloseProtocol(theLAPType: ABByte): OsErr;

	FUNCTION LAPRead(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION LAPWrite(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION LAPRdCancel(abRecord: ABRecHandle): OsErr;

	FUNCTION DDPOpenSocket(VAR theSocket: Byte; sktListener: Ptr): OsErr;

	FUNCTION DDPCloseSocket(theSocket: Byte): OsErr;

	FUNCTION DDPRead(abRecord: ABRecHandle; retCksumErrs: BOOLEAN;
					 async: BOOLEAN): OsErr;

	FUNCTION DDPWrite(abRecord: ABRecHandle; doCheckSum: BOOLEAN;
					  async: BOOLEAN): OsErr;

	FUNCTION DDPRdCancel(abRecord: ABRecHandle): OsErr;

	FUNCTION NBPLoad: OsErr;

	FUNCTION NBPUnLoad: OsErr;

	FUNCTION NBPLookUp(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION NBPConfirm(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION NBPRegister(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION NBPRemove(EntityName: EntityPtr): OsErr;

	FUNCTION NBPExtract(theBuffer: Ptr; numInBuf: INTEGER; whichOne: INTEGER;
						VAR abEntity: EntityName; VAR address: AddrBlock): OsErr;

	FUNCTION ATPLoad: OsErr;

	FUNCTION ATPUnLoad: OsErr;

	FUNCTION ATPOpenSocket(addrRcvd: AddrBlock; VAR atpSocket: Byte): OsErr;

	FUNCTION ATPCloseSocket(atpSocket: Byte): OsErr;

	FUNCTION ATPSndRequest(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION ATPGetRequest(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION ATPSndRsp(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION ATPAddRsp(abRecord: ABRecHandle): OsErr;

	FUNCTION ATPRequest(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION ATPResponse(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION ATPReqCancel(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	FUNCTION ATPRspCancel(abRecord: ABRecHandle; async: BOOLEAN): OsErr;

	PROCEDURE RemoveHdlBlocks;
	   { RemoveHdlBlks is a routine that is called automatically at the beginning of
		 every pascal call.  It checks for free (disposable) memory blocks that
		 the interface has allocated, and disposes of them.  The memory blocks have
		 been allocated by the NewHandle call.	Most of these memory blocks are
		 small (on the order of 20-50 bytes).  The user, at his option, may also
		 make the call whenever s/he wants to.	The general rule is that one memory
		 block will be allocated every time a network call is made; and it will
		 not be free until the call completes.}

	FUNCTION GetNodeAddress(VAR myNode, myNet: INTEGER): OsErr;

	FUNCTION MPPOpen: OsErr;

	FUNCTION MPPClose: OsErr;

	FUNCTION IsMPPOpen: BOOLEAN;

	FUNCTION IsATPOpen: BOOLEAN;


{********* NEW APPLETALK CALLS START HERE ***********}


FUNCTION OpenXPP(VAR xppRefnum: INTEGER): OSErr;

FUNCTION ASPOpenSession(xParamBlock: XPPParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION ASPCloseSession(xParamBlock: XPPParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION ASPAbortOS(xParamBlock: XPPParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION ASPGetParms(xParamBlock: XPPParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION ASPCloseAll(xParamBlock: XPPParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION ASPUserWrite(xParamBlock: XPPParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION ASPUserCommand(xParamBlock: XPPParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION ASPGetStatus(xParamBlock: XPPParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION AFPCommand(xParamBlock: XPPParmBlkPtr; async: BOOLEAN): OSErr;


END.
