{
  File: AppleTalk.p

 Version: 3.2a1

 Copyright Apple Computer, Inc. 1984, 1985, 1986
 All Rights Reserved

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
	  LAPProtErr = - 94;
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

	TYPE

	  ABByte = 1..127;

	  STR32 = STRING[32];

	  ABCallType = (tLAPRead, tLAPWrite, tDDPRead, tDDPWrite, tNBPLookUp,
					tNBPConfirm, tNBPRegister, tATPSndRequest, tATPGetRequest,
					tATPSdRsp, tATPAddRsp, tATPRequest, tATPResponse);

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
					 BuffSize: INTEGER;
					 BuffPtr: Ptr;
					 DataSize: INTEGER;
					 UserBytes: LongInt;
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

END.
